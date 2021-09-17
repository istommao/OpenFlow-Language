from src.app import APP

app = APP


if __name__ == "__main__":
    import uvicorn
    uvicorn.run('main:app', reload=True, host='0.0.0.0', port=6545)
