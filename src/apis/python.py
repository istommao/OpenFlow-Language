"""python api."""
from fastapi import Request, APIRouter

from pydantic import BaseModel

from src.services.python import exec_code

router = APIRouter()


class CodeDataForm(BaseModel):
    code_data: str

    class Config:
        use_enum_values = True


@router.post('/run_code')
async def run_python_code(form: CodeDataForm):
    result = exec_code(form.code_data)
    resp = {
        'result': result
    }
    return resp
