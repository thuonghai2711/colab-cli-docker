FROM python:3.12-slim

# Cài google-colab-cli (bản release mới nhất)
RUN pip install --no-cache-dir google-colab-cli

WORKDIR /workspace
ENTRYPOINT ["colab"]
CMD ["--help"]
