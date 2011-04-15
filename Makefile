all: docs graph

docs:
	yard doc --verbose --protected --private 'src/**/*.rb' --tag final:"Final class" --tag virtual:"Virtual function"

graph:
	yard graph --full --protected --private | tee doc/uml.dot | circo -Tsvg -Gmindist=0.15 > doc/uml.svg
	#-Gpage=8,11 -Gmargin=0.2 > doc/uml.ps

clean:
	rm -rf *~ */*~ */*/*~ */*/*/*~ doc

.PHONY: all docs graph clean
