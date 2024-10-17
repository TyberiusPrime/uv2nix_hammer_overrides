from pathlib import Path

<<<<<<< HEAD
# they all need the same override,
# and we can't (easily) do it with a rule
# since it's only blowing up when the venv is combined
=======
>>>>>>> d82985e0e4f306bcf1437ed3489dbbecc1764c5c
drvs = """      "/nix/store/333ggld5k7n0a4w693xg83p1a4ks6z2j-nvidia-cuda-runtime-cu12-12.1.105.drv": {
      "/nix/store/75n2gq1rwlgr92nkp7fa6b5xvhcsq61j-nvidia-cufft-cu12-11.0.2.54.drv": {
      "/nix/store/7hhwgsmhbm7qrxnw5n1fn2mc54vnf7wr-nvidia-cusparse-cu12-12.1.0.106.drv": {
      "/nix/store/cbhsn77arbjibwym04817g3r984kygik-nvidia-cudnn-cu12-9.1.0.70.drv": {
      "/nix/store/dr736vs0rg0sybdzyzp1rn9axqgiphv1-nvidia-curand-cu12-10.3.2.106.drv": {
      "/nix/store/jibhasfgp6x8g8vf6ic7sa53k8mcs6vj-nvidia-cuda-nvrtc-cu12-12.1.105.drv": {
      "/nix/store/sk98ka8yf032nb53jdid7riw7i5qq24q-nvidia-cuda-cupti-cu12-12.1.105.drv": {
      "/nix/store/v6ljia1swbmkpl5a49khd380imj5hqay-nvidia-cusolver-cu12-11.4.5.107.drv": {
      "/nix/store/vvc99k1k11i1bdmaj98dl34gzjf09idi-nvidia-cublas-cu12-12.1.3.1.drv":
        File 1: /nix/store/9a773jdzz4fh24n4bmwammhidq1lv8al-nvidia-nvtx-cu12-12.1.105/lib/python3.12/site-packages/nvidia/__pycache__/__init__.cpython-312.opt-2.pyc
       >      File 2: /nix/store/rs7214axar5xx0v2xl1y0axic8k4mm3n-nvidia-nccl-cu12-2.20.5/lib/python3.12/site-packages/nvidia/__pycache__/__init__.cpython-312.opt-2.pyc.

      """.strip().split("\n")


for line in drvs:
    line = line.strip()
    line = line[line.find("/nix") : line.find(".drv")]
    parts = line.split("/")
    name = parts[3]
    hash, name = name.split("-", 1)
    version = name[name.rfind("-") + 1 :]
    name = name[: name.rfind("-")]
    print(name, version)
    p = Path(name) / version
    p.mkdir(exist_ok=True, parents=True)
    if not (p / "default.nix").exists():
        with open(p / "default.nix", "w") as f:
            f.write("""
    {
        dontUsePyprojectBytecode = true;
    }
                    """)
