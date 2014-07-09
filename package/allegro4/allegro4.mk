#############################################################
#
# Allegro5: a game programming library
#
#############################################################
ALLEGRO4_VERSION:=4.4.1.1
ALLEGRO4_SOURCE:=allegro-$(ALLEGRO4_VERSION).tar.gz
ALLEGRO4_SITE:=http://downloads.sourceforge.net/project/alleg/allegro/$(ALLEGRO4_VERSION)
ALLEGRO4_CAT:=zcat
ALLEGRO4_DIR:=$(BUILD_DIR)/allegro-$(ALLEGRO4_VERSION)

ALLEGRO4_CONF_OPT=-DSHARED=off -DWANT_MODULES=off -DWANT_X11=off -DWANT_LINUX_CONSOLE=on -DWANT_LINUX_VGA=off -DWANT_LINUX_FBCON=on -DWANT_LINUX_SVGALIB=off -DWANT_ALLEGROGL=off -DWANT_LOADPNG=on -DWANT_LOGG=off -DWANT_JPGALLEG=on -DWANT_EXAMPLES=off -DWANT_TOOLS=on -DWANT_TESTS=off 

#ALLEGRO4_CONF_OPT=-DWANT_LINUX_CONSOLE=on -DWANT_LINUX_FBCON=on -DWANT_LINUX_SVGALIB=off -DWANT_X11=off -DWANT_TESTS=off -DWANT_ALSA=off -DWANT_OSS=off -DWANT_JACK=off-DWANT_SGIAUDIO=off -DWANT_VORBIS=off -DWANT_OGG=off -DWANT_LOGG=off -DWANT_MODULES=off -DWANT_ALLEGROGL=off 

$(eval $(cmake-package))
