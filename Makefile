IMAGE_NAME ?= s3-resource
VERSION ?= 1.2.3


all: final.tgz

final.tgz: rootfs.tgz resource_metadata.json
	tar -czf $@ $^

resource_metadata.json:
	echo '{ \
  "type": "s3", \
  "version": "$(VERSION)", \
  "privileged": false \
}' > $@

rootfs.tgz: image
	docker save $(IMAGE_NAME) | gzip > $@

image:
	docker build -t $(IMAGE_NAME) .

.PHONY: image
