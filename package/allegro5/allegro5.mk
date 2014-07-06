#############################################################
#
# Allegro5: a game programming library
#
#############################################################
ALLEGRO5_VERSION:=5.0.10
ALLEGRO5_SOURCE:=allegro-$(ALLEGRO5_VERSION).tar.gz
ALLEGRO5_SITE:=http://downloads.sourceforge.net/project/alleg/allegro/$(ALLEGRO5_VERSION)
ALLEGRO5_CAT:=zcat
ALLEGRO5_DIR:=$(BUILD_DIR)/allegro-$(ALLEGRO5_VERSION)

#ALLEGRO_CONF_OPT=-DWANT_LINUX_CONSOLE=on -DWANT_LINUX_FBCON=on -DWANT_LINUX_SVGALIB=off -DWANT_X11=off -DWANT_TESTS=off -DWANT_ALSA=off -DWANT_OSS=off -DWANT_JACK=off-DWANT_SGIAUDIO=off -DWANT_VORBIS=off -DWANT_OGG=off -DWANT_LOGG=off -DWANT_MODULES=off -DWANT_ALLEGROGL=off 

ALLEGRO_CONF_OPT=-DWANT_X11=off -DWANT_X11_XF86VIDMODE=off -DWANT_X11_XINERAMA=off -DWANT_X11_XRANDR=off -DWANT_D3D=off -DWANT_D3D9EX=off -DWANT_OPENGL=off -DWANT_AUDIO=off -DWANT_MEMFILE=off -DWANT_PHYSFS=off -DWANT_NATIVE_DIALOG=off -DWANT_DOCS=off -DNO_FPU=on -DWANT_TESTS=off -DWANT_PRIMITIVES=off -DSHARED=on -DSTATIC=on -DGRADE_STANDARD=on -DGRADE_DEBUG=off -DGRADE_PROFILE=off

$(eval $(cmake-package))
