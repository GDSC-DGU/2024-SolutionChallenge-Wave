# 기존의 FROM 명령어 등
FROM python:3.12-alpine3.19

# 나머지 Dockerfile 내용
WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app

# gunicorn 실행 명령어에 타임아웃 옵션 추가
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "--timeout", "150", "app:app"]
