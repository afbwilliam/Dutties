from distutils.core import setup, Extension
import sys

def run_setup():
    is_64bits = sys.maxsize > 2**32
    if not is_64bits:
        extra_args = ["-m32"]
    else:
        extra_args = ["-m64"]
    cfgmcc_module = Extension('_cfgmcc',
                               extra_compile_args=extra_args,
                               extra_link_args=extra_args,
                               sources=['cfgmcc_wrap.c', '../../C/api/cfgmcc.c'],
                               define_macros=[('PYPREFIXCFG', None), ('_CRT_SECURE_NO_WARNINGS', None)],
                               include_dirs=['../../C/api']
                            )

    setup (name = 'cfgmcc',
           version = '1',
           ext_modules = [cfgmcc_module],
           py_modules= ["cfgmcc"],
           )

if __name__ == "__main__":
    run_setup()
