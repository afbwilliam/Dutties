from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    gevmcc_module = Extension('_gevmcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['gevmcc_wrap.c', '../../C/api/gevmcc.c'],
                               define_macros=[('PYPREFIXGEV', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'gevmcc',
           version = '6',
           ext_modules = [gevmcc_module],
           py_modules= ["gevmcc"],
           )

if __name__ == "__main__":
    run_setup()
