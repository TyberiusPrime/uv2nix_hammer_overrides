{
  disabledTests = [
    "test_hello_develop" # tries setuptools develop install
    "test_source_distribution" # pip has no way to install missing dependencies
    "test_wheel" # pip has no way to install missing dependencies
    "test_fortran_compiler" # passes if gfortran is available
    "test_install_command" # tries to alter out path
    "test_test_command" # tries to alter out path
    "test_setup" # tries to install using distutils
    "test_pep518" # pip exits with code 1
    "test_dual_pep518" # pip exits with code 1
    "test_isolated_env_trigger_reconfigure" # Regex pattern 'exit skbuild saving cmake spec' does not match 'exit skbuild running make'.
    "test_hello_wheel" # [Errno 2] No such file or directory: '_skbuild/linux-x86_64-3.9/setuptools/bdist.linux-x86_64/wheel/helloModule.py'
    "test_hello_cython_sdist" # [Errno 2] No such file or directory: 'dist/hello-cython-1.2.3.tar.gz'
    "test_hello_pure_sdist" # [Errno 2] No such file or directory: 'dist/hello-pure-1.2.3.tar.gz'
    # sdist contents differ, contains additional setup.py
    "test_hello_sdist"
    "test_manifest_in_sdist"
    "test_sdist_with_symlinks"
  ];
}
