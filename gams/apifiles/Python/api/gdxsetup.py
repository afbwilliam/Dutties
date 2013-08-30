from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    gdxcc_module = Extension('_gdxcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['gdxcc_wrap.c', '../../C/api/gdxcc.c'],
                               define_macros=[('PYPREFIXGDX', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'gdxcc',
           version = '7',
           ext_modules = [gdxcc_module],
           py_modules= ["gdxcc"],
           )

if __name__ == "__main__":
    run_setup()
