from IPython.core.interactiveshell import InteractiveShell
from IPython.utils.io import capture_output

shell = InteractiveShell.instance()


def run_code(code_string):
    with capture_output() as io:
        res = shell.run_cell(code_string)

        res_out = io.stdout
        return res_out


if __name__ == '__main__':
    code_string = 'print("Hello OpenFlow")'
    run_code(code_string)
