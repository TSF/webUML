GIT=git
TARGET=index.html
SITE=../webUML-site
REMOTE=github

all: publish

nothing-to-commit: supporters.txt
	@git status $< | grep "modified:   $<" > /dev/null || exit 1

commit: supporters.txt nothing-to-commit
	@echo "*** committing "
	@( ${GIT} add $<; \
		 ${GIT} commit -m "generated new supporters HTML page"; \
		 ${GIT} push ${REMOTE} )

publish: commit ${TARGET} ${SITE}
	@echo "*** publishing $<"
	@cp ${TARGET} ${SITE}/Supporters/
	@( cd ${SITE}; \
		${GIT} add Supporters/index.html; \
		${GIT} commit -m "imported generated Supporters/index.html"; \
		${GIT} push ${REMOTE} )

${TARGET}: supporters.txt supporters.tpl
	@echo "*** regenerating $@"
	@python generate_supporters.py $< > $@

clean:
	@echo "*** cleaning up"
	@rm -f ${TARGET}
