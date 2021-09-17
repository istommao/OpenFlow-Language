"""routers map"""
from src.apis import python


ROUTER_CONFIG = [
    (
        python.router,
        {
            'prefix': '/api/python',
            'tags': ['python'],
            'responses': {404: {'description': '404 Not found'}}
        }
    ),
]
