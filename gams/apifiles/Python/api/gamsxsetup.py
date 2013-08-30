from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    gamsxcc_module = Extension('_gamsxcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['gamsxcc_wrap.c', '../../C/api/gamsxcc.c'],
                               define_macros=[('PYPREFIXGAMSX', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'gamsxcc',
           version = '1',
           ext_modules = [gamsxcc_module],
           py_modules= ["gamsxcc"],
           )

if __name__ == "__main__":
    run_setup()
