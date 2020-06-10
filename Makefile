run =  docker run -it --rm -v $(PWD):/usr/src/app butts $(1)

all: test

image:
	docker build -t butts .

run: image
	$(call run)

shell: image
	$(call run,bash)

test: image
	$(call run,bundle exec rake)
