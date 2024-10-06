# Dockerfile
FROM python:3.11-alpine AS base

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache gcc musl-dev libffi-dev postgresql-dev nodejs npm

# Copy requirements and install Python dependencies
COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --upgrade pip && pip install -r backend/requirements.txt

# Copy source code
COPY backend ./backend
COPY frontend ./frontend

# Build the React app
WORKDIR /app/frontend
RUN npm install && npm run build

# Expose ports
EXPOSE 8000

# Start both Django and React
CMD ["sh", "-c", "python backend/manage.py collectstatic --noinput && python backend/manage.py migrate & npm start --prefix frontend"]
