all:
	cd lib && make
	#cabal update
	#cabal configure
	cabal build
	mv dist/build/latc_x86/latc_x86 .

clean:
	cabal clean
	cd lib && make clean
