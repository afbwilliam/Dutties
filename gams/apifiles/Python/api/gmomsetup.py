from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    gmomcc_module = Extension('_gmomcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['gmomcc_wrap.c', '../../C/api/gmomcc.c'],
                               define_macros=[('PYPREFIXGMO', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'gmomcc',
           version = '11',
           ext_modules = [gmomcc_module],
           py_modules= ["gmomcc"],
           )

if __name__ == "__main__":
    run_setup()
