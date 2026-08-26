# colab-cli-docker

Chạy [Google Colab CLI](https://github.com/googlecolab/google-colab-cli) trong Docker — quản lý session Colab (CPU/GPU/TPU) trực tiếp từ terminal.

## Tính năng

- 🐳 Image Docker nhẹ (`python:3.12-slim` + `google-colab-cli`)
- 🚀 Tạo session Colab với CPU, GPU (T4/L4/G4/H100/A100) hoặc TPU (v5e/v6e)
- 💻 Chạy script Python trên VM Colab, upload/download file, SSH vào runtime
- 🔐 Xác thực OAuth2 Google (hoặc ADC)

## Build image

```bash
docker build -t colab-cli:latest .
```

## Sử dụng

### Xem help

```bash
docker run --rm colab-cli:latest --help
```

### Tạo session mới (cần xác thực Google)

```bash
# CPU
docker run --rm -it colab-cli:latest new

# GPU T4
docker run --rm -it colab-cli:latest new --gpu T4

# TPU v5e
docker run --rm -it colab-cli:latest new --tpu v5e1
```

CLI sẽ in ra URL xác thực OAuth — mở trong trình duyệt, bấm **Approve**, rồi dán authorization code vào terminal.

### Chạy script trên Colab VM (fresh VM, tự release sau khi xong)

```bash
docker run --rm -it -v $(pwd):/workspace colab-cli:latest run /workspace/script.py
```

### Các lệnh khác

| Lệnh | Mô tả |
|------|-------|
| `colab sessions` | Liệt kê session đang chạy |
| `colab status` | Xem trạng thái session |
| `colab exec <code>` | Chạy code trong session |
| `colab repl` | REPL tương tác |
| `colab upload / download` | Truyền file với session |
| `colab ssh` | SSH vào Colab runtime |
| `colab drivemount` | Mount Google Drive |
| `colab stop` | Dừng session |

## Xác thực

Hai phương thức:

1. **OAuth2** (mặc định) — flow tương tác, cần browser
2. **ADC** (Application Default Credentials) — dùng cho CI/automation:

```bash
docker run --rm -it \
  -v ~/.config/gcloud:/root/.config/gcloud \
  colab-cli:latest --auth adc new
```

## Cấu trúc repo

```
colab-cli-docker/
├── Dockerfile      # Image python:3.12-slim + google-colab-cli
└── README.md
```

## Tham khảo

- [google-colab-cli (repo gốc)](https://github.com/googlecolab/google-colab-cli)
- [Google Colab](https://colab.research.google.com/)
