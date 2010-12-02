TARGET=index.html

all: ${TARGET}

${TARGET}: supporters.txt supporters.tpl
		python generate_supporters.py $< > $@

clean:
		rm -f ${TARGET}