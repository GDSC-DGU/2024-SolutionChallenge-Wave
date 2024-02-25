#  ❇️ Server Deployment
### Local Setup:

#### Main Server(spring)
1. **Create `application-secret.yml` in spring**

    navigate to the `Wave-backend` folder, then proceed to the `spring` directory. Within this directory, create a file named `application-secret.yml` in '/src/main/resources'. Add the following configuration to the file:

    ```yaml
    spring:
      datasource:
        url: jdbc:mysql://{YOUR_DATABASE_URL}:3306/{YOUR_DATABASE_NAME}?serverTimezone=Asia/Seoul&characterEncoding=UTF-8
        username: {USERNAME}
        password: {PASSWORD}
        driver-class-name: com.mysql.cj.jdbc.Driver
        hikari:
          pool-name: jpa-hikari-pool
          maximum-pool-size: 15
          idleTimeout: 400
          maxLifeTime: 400
          data-source-properties:
            rewriteBatchedStatements: true

    jwt:
      secret-Key: {SECRET_KEY}
      access-token-expire-period: {ACCESS_TOKEN_EXPIRE_PERIOD}
      refresh-token-expire-period: {REFRESH_TOKEN_EXPIRE_PERIOD}
    ```

     **Important Configuration Note:**
    - Replace `{YOUR_DATABASE_URL}`, `{YOUR_DATABASE_NAME}`, `{USERNAME}`, and `{PASSWORD}` with your actual database URL, database name, username, and password, respectively.
    - For `{SECRET_KEY}`, `{ACCESS_TOKEN_EXPIRE_PERIOD}`, and `{REFRESH_TOKEN_EXPIRE_PERIOD}`, replace these placeholders with your actual JWT secret key, access token expiration time, and refresh token expiration time.


2. **Building Docker Image**
    ```
    docker build -t {USERNAME}/{SPRING_REPOSITORY_NAME} .
    ```

    Replace `USERNAME`, `REPOSITORY_NAME` with your Docker Hub username.

3. **Pushing to Docker Hub**
    ```
    docker push {USERNAME}/{SPRING_REPOSITORY_NAME}
    ```

    Again, ensure that `USERNAME`, `REPOSITORY_NAME` is replaced with your actual Docker Hub username.

#### Crawling Server(flask)

1. **Create `config.py` in flask**

   navigate to the `Wave-backend` folder, then proceed to the `flask` directory. Within this directory, create a file named `config.py`. Add the following configuration to the file:

    ```yaml
    SERVER_END_POINT = "http://{DOCKER_COMPOSE_SPRING_SERVICE_NAME}:8080/api/v1/countries/crawling-news"
    ```

   `DOCKER_COMPOSE_SPRING_SERVICE_NAME` refers to the name assigned to your Spring application service within the `Docker Compose file`.
    
3. **Building Docker Image**
    ```
    docker build -t {USERNAME}/{FLASK_REPOSITORY_NAME} .
    ```

    Replace `USERNAME`, `REPOSITORY_NAME` with your Docker Hub username.

4. **Pushing to Docker Hub**
    ```
    docker push {USERNAME}/{FLASK_REPOSITORY_NAME}
    ```

    Again, ensure that `USERNAME`, `REPOSITORY_NAME` is replaced with your actual Docker Hub username.


### Deploy Setup:

1. **Pulling Docker Images**
   
   For the Spring application:
     ```
     docker pull {USERNAME}/{SPRING_REPOSITORY_NAME}
     ```

   For the Flask application:
     ```
     docker pull {USERNAME}/{FLASK_REPOSITORY_NAME}
     ```
     
3. **Init.sql**
   
To initialize your database schema, you should create an init.sql file containing the schema definitions. This file should be placed in the same directory as your docker-compose.yml file. Including this init.sql file in your project at the specified location will ensure that your database is correctly set up when you start your application using Docker Compose.

   ```sql
    -- Users Table
    CREATE TABLE `users` (
      `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
      `nickname` VARCHAR(255) NOT NULL,
      `total_donation` INT DEFAULT 0,
      `total_donation_cnt` INT DEFAULT 0,
      `refresh_token` VARCHAR(255),
      `serial_id` VARCHAR(255) NOT NULL UNIQUE,
      `is_login` TINYINT(1),
      `is_light_on` TINYINT(1) DEFAULT 0,
      `role` VARCHAR(255) NOT NULL,
      `recent_amount_badge` VARCHAR(255),
      `recent_count_badge` VARCHAR(255),
      `created_at` DATETIME NOT NULL
    );
    
    -- Donation Country Table
    CREATE TABLE `donation_country` (
      `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
      `country_id` BIGINT,
      `user_id` BIGINT,
      `donation` INT,
      `created_at` DATETIME NOT NULL,
      FOREIGN KEY (`country_id`) REFERENCES `country`(`id`),
      FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    );
    
    -- Country Table
    CREATE TABLE `country` (
      `id` BIGINT NOT NULL PRIMARY KEY,
      `name` VARCHAR(255) NOT NULL,
      `korean_name` VARCHAR(255) NOT NULL,
      `category` VARCHAR(255) NOT NULL,
      `is_donate` TINYINT(1) NOT NULL,
      `total_wave` INT,
      `last_wave` INT,
      `casualties` INT,
      `views` INT DEFAULT 0,
      `main_title` VARCHAR(255) NOT NULL,
      `sub_title` VARCHAR(255) NOT NULL,
      `image_url` VARCHAR(255) NOT NULL,
      `imageProducer` VARCHAR(255) NOT NULL,
      `detail_image_url` VARCHAR(255) NOT NULL,
      `detail_image_title` VARCHAR(255) NOT NULL,
      `detail_image_producer` VARCHAR(255) NOT NULL
    );
    
    -- Country Content Table
    CREATE TABLE `country_content` (
      `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
      `title` TEXT,
      `content` TEXT,
      `country_id` BIGINT,
      FOREIGN KEY (`country_id`) REFERENCES `country`(`id`)
    );
    
    -- News Table
    CREATE TABLE `news` (
      `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
      `news_image` TEXT NOT NULL,
      `news_title` TEXT NOT NULL,
      `news_url` TEXT NOT NULL,
      `date` DATE NOT NULL,
      `country_id` BIGINT,
      FOREIGN KEY (`country_id`) REFERENCES `country`(`id`)
    );
    
    -- User Count Badges Table
    CREATE TABLE `user_count_badges` (
      `user_id` BIGINT,
      `count_badge` VARCHAR(255),
      PRIMARY KEY (`user_id`, `count_badge`),
      FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    );
    
    -- User Amount Badges Table
    CREATE TABLE `user_amount_badges` (
      `user_id` BIGINT,
      `amount_badge` VARCHAR(255),
      PRIMARY KEY (`user_id`, `amount_badge`),
      FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    );
   
5. **Docker Compose Up**
   
   Ensure your Docker Compose file is updated with the correct service names, container names, and image names.

   ```yaml
   version: '3'

   services:
     {DATABASE_SERVICE_NAME}:
       image: mysql:8.0
       container_name: {CONTAINER_NAME}
       ports:
         - "3306:3306"
       environment:
         MYSQL_DATABASE: {DATABASE_NAME}
         MYSQL_USER: {DATABASE_USERNAME}
         MYSQL_PASSWORD: {DATABASE_PASSWORD}
         MYSQL_ROOT_PASSWORD: {DATABASE_ROOT_PASSWORD}
         TZ: 'Asia/Seoul'  # Timezone setting for Korea
       volumes:
         - wave-db:/var/lib/mysql
         - ./init.sql:/docker-entrypoint-initdb.d/init.sql
       restart: always

     {FLASK_SERVICE_NAME}:
       image: {USERNAME}/{FLASK_REPOSITORY_NAME}:latest
       container_name: flaskapp
       ports:
         - "5000:5000"
       environment:
         TZ: 'Asia/Seoul'  # Timezone setting for Korea
       depends_on:
         - database
       restart: always

     {SPRING_SERVICE_NAME}:
       image: {USERNAME}/{SPRING_REPOSITORY_NAME}:latest
       container_name: springapp
       ports:
         - "8080:8080"
       environment:
         TZ: 'Asia/Seoul'  # Timezone setting for Korea
       depends_on:
         - {DATABASE_SERVICE_NAME}
       restart: always

   volumes:
     wave-db:
