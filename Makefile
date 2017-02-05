ARCHS = armv7 arm64
TARGET = iphone:clang:9.2:9.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ReacherSwitcher
ReacherSwitcher_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
