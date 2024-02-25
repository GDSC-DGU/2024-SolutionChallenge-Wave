import requests
from bs4 import BeautifulSoup
from config import SERVER_END_POINT
from apscheduler.schedulers.background import BackgroundScheduler
import logging
from flask import Flask, jsonify

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)

COUNTRY_IDS = {
    "Uganda": 165,
    "Ukraine": 166,
    "Venezuela": 170,
    "Yemen": 173,
    "Afghanistan": 1,
    "Burkina Faso": 14,
    "Congo": 33,  # Specify if it's the Democratic Republic of the Congo or the Republic of the Congo
    "Colombia": 35,
    "Ethiopia": 51,
    "Haiti": 70,
    "Iraq": 76,
    "Kenya": 84,
    "Lebanon": 91,
    "Sri Lanka": 94,
    "Mali": 104,
    "Myanmar": 105,
    "Mozambique": 108,
    "Niger": 114,
    "Pakistan": 122,
    "Palestine": 132,
    "South Sudan": 140,
    "Somalia": 146,
    "Syria": 153
}


def extract_largest_image(srcset):
    images = srcset.split(', ')
    largest_image_url = ''
    largest_size = 0
    for image in images:
        parts = image.split(' ')
        if len(parts) == 2:
            url, size_info = parts
            if size_info.endswith('w'):
                size = int(size_info.replace('w', ''))
                if size > largest_size:
                    largest_size = size
                    largest_image_url = url
    return largest_image_url


@app.route('/flask/crawling', methods=['GET'])
def start_crawling():
    scheduled_crawling()
    return_data = {
        "success": True,
        "data": None,
        "error": None
    }
    return jsonify(return_data), 200


def scheduled_crawling():
    for country_name, country_id in COUNTRY_IDS.items():
        logging.info(f"country_name: {country_name}")

        link = f'https://news.google.com/search?q={country_name}&hl=en-US&gl=US&ceid=US:en'
        response = requests.get(link)
        soup = BeautifulSoup(response.content, 'html.parser')

        news_items = []

        articles = soup.find_all('article', class_='IFHyqb DeXSAc')[:5]

        for article in articles:
            title_tag = article.find('a', class_='JtKRv')
            title = title_tag.text.strip()

            link = 'https://news.google.com' + title_tag['href'][1:]  # 상대 경로를 절대 경로로 변환

            date_tag = article.find('time')
            date = date_tag['datetime'] if date_tag else "No date provided"

            image_tag = article.find('img', class_='Quavad')
            if image_tag and 'src' in image_tag.attrs:
                # 이미지 URL이 절대 경로인 경우 직접 사용
                image_url = image_tag['src']
                # 상대 경로인 경우 절대 경로로 변환
                if image_url.startswith('/'):
                    image_url = f'https://news.google.com{image_url}'
            elif image_tag and 'srcset' in image_tag.attrs:
                # srcset에서 가장 큰 이미지 URL 추출하고, 상대 경로인 경우 절대 경로로 변환
                image_url = extract_largest_image(image_tag['srcset'])
                if image_url.startswith('/'):
                    image_url = f'https://news.google.com{image_url}'
            else:
                image_url = None  # 이미지가 없는 경우

            news_items.append({
                'title': title,
                'link': link,
                'date': date,
                'image_url': image_url
            })

        transformed_data = {
            "id": country_id,
            "data": news_items
        }

        server_url = SERVER_END_POINT
        headers = {'Content-Type': 'application/json; charset=utf-8'}
        response = requests.post(server_url, json=transformed_data, headers=headers)

        if response.status_code == 200:
            logging.info(f"Successfully sent news items for {country_name}.")
        else:
            logging.error(f"Failed to send data for {country_name}. HTTP Status Code: {response.status_code}")



scheduler = BackgroundScheduler()
scheduler.add_job(func=scheduled_crawling, trigger='interval', hours=1)
scheduler.start()

if __name__ == '__main__':
    app.run(debug=True)
