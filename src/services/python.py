from IPython.core.interactiveshell import InteractiveShell
from IPython.utils.io import capture_output

shell = InteractiveShell.instance()


def exec_code(code_string):
    with capture_output() as io:
        try:
            exec(code_string, shell.user_global_ns, shell.user_ns)
        except Exception as e:
            return str(e)
        else:
            res_out, res_err = io.stdout, io.stderr
            if res_err:
                return res_err
            else:
                return res_out


def run_code(code_string):
    with capture_output() as io:
        res = shell.run_cell(code_string)

        res_out = io.stdout
        return res_out


if __name__ == '__main__':
    code_string = 'print("Hello OpenFlow")'
    exec_code(code_string)
