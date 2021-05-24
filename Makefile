PYTHON2 := python

aupd-extract: extract2g
	mkdir -p tmp
	unzip -n iPod_29.1.1.3.ipsw -d tmp
	./extract2g -l tmp/Firmware-29.8.1.3
	./extract2g --extract=aupd tmp/Firmware-29.8.1.3
	mv aupd.fw tmp/
	#ibugger/ipodcrypt.py decryptfirmware tmp/aupd.noheader.fw tmp/aupd.decrypted.noheader.fw
	ibugger/ipodcrypt.py decryptfirmware tmp/aupd.fw tmp/aupd.decrypted.fw
	dd if=tmp/aupd.decrypted.fw of=tmp/aupd.decrypted.noheader.fw bs=2048 skip=1
	#./extract2g | grep "aupd" | cut -d " " -f 6

ipsw-from-extracted-aupd: extract2g tmp/aupd.decrypted.fw
	ibugger/ipodcrypt.py cryptfirmware tmp/aupd.decrypted.noheader.fw tmp/aupd.fw2

extract2g: extract2g.c extract2g.h
	$(CC) extract2g.c -o $@

clean:
	rm -f extract2g
	rm -rf tmp

.PHONY: aupd-extract clean
