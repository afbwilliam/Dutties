from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    optcc_module = Extension('_optcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['optcc_wrap.c', '../../C/api/optcc.c'],
                               define_macros=[('PYPREFIXOPT', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'optcc',
           version = '2',
           ext_modules = [optcc_module],
           py_modules= ["optcc"],
           )

if __name__ == "__main__":
    run_setup()
