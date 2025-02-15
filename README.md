# Task Management

## Project Overview

This is a task management system backend API developed using Go language, using MongoDB as the database, providing basic task CRUD functionality. The frontend is built with React + TypeScript + Vite, utilizing Chakra UI component library to implement a modern user interface.

## Tech Stack

### Backend

- Go
- Fiber (Web Framework)
- MongoDB Atlas (Database)
- Air (Hot Reload Tool)

### Frontend

- React 18
- TypeScript
- Vite
- Chakra UI
- React Query
- React Icons

### Dependencies

Backend Dependencies:

- github.com/gofiber/fiber/v2
- github.com/joho/godotenv
- go.mongodb.org/mongo-driver

Frontend Dependencies:

- @chakra-ui/react
- @tanstack/react-query
- react-icons
- framer-motion

## Features

- Get all tasks list
- Create new task
- Update task status
- Delete task
- Environment variable configuration support
- Production static file serving support
- Dark/Light theme switching
- Responsive design

## API Endpoints

| Method | Path           | Description        |
| ------ | -------------- | ------------------ |
| GET    | /api/todos     | Get all tasks      |
| POST   | /api/todos     | Create new task    |
| PATCH  | /api/todos/:id | Update task status |
| DELETE | /api/todos/:id | Delete task        |

## Installation and Running

### Prerequisites

- Go 1.16+
- MongoDB Atlas account
- Node.js 16+
- npm or yarn

### Environment Variables Configuration

Create a `.env` file in the project root directory and configure the following environment variables:

```
PORT=3000 # Server running port
MONGODB_URI=<your MongoDB connection URI> # MongoDB Atlas connection string
ENV=development # Environment setting (development/production)
```

Note: Do not commit the `.env` file containing sensitive information to version control system. Make sure the `.env` file is added to `.gitignore`.
