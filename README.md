# Nexu Exercise Project

This project is an API built with Ruby on Rails. It provides endpoints
to manage brands and car models.

It uses Docker for containerization and has support for DevContainers to
facilitate development in consistent environments.

## Requirements

- Docker
- Docker Compose
- Visual Studio Code (optional, but recommended for using DevContainers)

## How to Run with DevContainer

To set up and run the project using a DevContainer, follow these steps:

1. **Clone the repository:**

```
git clone https://github.com/rogalvil/nexu-exercise
cd nexu-exercise
```

2. **Open the project in Visual Studio Code:**

```
code .
```

3. **Reopen in Container:**

If you have the Dev Containers extension installed.

https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

You should see a prompt in the bottom right corner asking if you want to reopen the project in a container. Click "Reopen in Container".

![Screenshot 2024-06-26 at 7 07 28 a m](https://github.com/rogalvil/tgc/assets/695923/666428ad-6cda-44a2-8650-da9e0b3659dd)

If you don't see the prompt, you can open the Command Palette (Ctrl+Shift+P or Cmd+Shift+P on macOS) and select "Remote-Containers: Reopen in Container".

4. **Wait for the container to build and start:**

The first time you open the project in a container, it will build the Docker image specified in the `Dockerfile` and set up the development environment. This may take a few minutes.

5. **Set up the database:**

Once the container is up and running, open a new terminal in VS Code and run:

```
rails db:create db:migrate
```

6. Create master.key file, you can use the following command:

```
rails credentials:edit
```

7. **Start the Rails server:**

In the terminal, run:

```
rails server -b 0.0.0.0
```

or click on Run and Debug in the sidebar and select "Rails Server".

![Screenshot 2024-06-26 at 7 08 06 a m](https://github.com/rogalvil/tgc/assets/695923/aea7dd1e-66bd-4873-8d95-22d65ec2edae)

and then click on the green play button.

![Screenshot 2024-06-26 at 7 08 48 a m](https://github.com/rogalvil/tgc/assets/695923/6811ac40-e241-4d66-a365-cdc85a09b0bd)

then apper a controls to manage the server.

![Screenshot 2024-06-26 at 7 09 00 a m](https://github.com/rogalvil/tgc/assets/695923/cca2d9f6-b6ee-49c4-8564-fba1564228ef)

8. **Access the application:**

The application should now be running and accessible at `http://localhost:3000`.

9. **Run tests:**

To run the test suite, use the following command in the terminal:

```
rspec
```

By following these steps, you should be able to set up and run the project using a DevContainer in Visual Studio Code.

## How to Run with Docker

To set up and run the project using Docker, follow these steps:

1. **Clone the repository:**

```
git clone https://github.com/rogalvil/nexu-exercise
cd nexu-exercise
```

2. **Build the Docker images:**

```
docker-compose build development
```

3. **Run the containers in bash mode:**

Run the development service in bash mode to get inside the container by using
the following command:

```
docker-compose run development bash
```

5. **Run the containers:**

```
docker-compose up development
```

6. **Set up the database:**

Inside the containers in bash mode you need to migrate the database:

```
rails db:create db:migrate
```

Or once the containers are up and running, you need to create and migrate the database. Open a new terminal window and run:

```
docker-compose exec development rails db:create db:migrate
```

7. Create master.key file, you can use the following command:

Inside the containers in bash mode you need to migrate the database:

```
rails credentials:edit
```

Or once the containers are up and running, you need to create the master.key file. Open a new terminal window and run:

```
docker-compose exec development rails credentials:edit
```

7. **Access the application:**

The application should now be running and accessible at `http://localhost:3000`.

8. **Run tests:**

To run the test suite, use the following command in bash mode:

```
rspec
```

Or once the containers are up and running, you can run the tests using the following command in a new terminal window

```
docker-compose exec development rspec
```

9. **Stop the containers:**

To stop the running containers, use:

```
docker-compose down development
```

By following these steps, you should be able to set up and run the project using Docker.

## Endpoints

The API are deployed in Render and you can access the endpoints using the following URL:

```
https://nexu-exercise.onrender.com/
```
