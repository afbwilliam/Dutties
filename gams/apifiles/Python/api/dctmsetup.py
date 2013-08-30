from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    dctmcc_module = Extension('_dctmcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['dctmcc_wrap.c', '../../C/api/dctmcc.c'],
                               define_macros=[('PYPREFIXDCT', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'dctmcc',
           version = '1',
           ext_modules = [dctmcc_module],
           py_modules= ["dctmcc"],
           )

if __name__ == "__main__":
    run_setup()
