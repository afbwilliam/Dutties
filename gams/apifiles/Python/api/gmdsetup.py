from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    gmdcc_module = Extension('_gmdcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['gmdcc_wrap.c', '../../C/api/gmdcc.c'],
                               define_macros=[('PYPREFIXGMD', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'gmdcc',
           version = '1',
           ext_modules = [gmdcc_module],
           py_modules= ["gmdcc"],
           )

if __name__ == "__main__":
    run_setup()
