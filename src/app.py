"""app"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.routers import ROUTER_CONFIG

APP = FastAPI(title='openflow-language')

APP.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def load_routers(app):
    for router, config in ROUTER_CONFIG:
        app.include_router(router, **config)


load_routers(APP)
