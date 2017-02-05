ARCHS = armv7 arm64
TARGET = iphone:clang:9.2:9.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ReacherSwitcher
ReacherSwitcher_FILES = RSSettingsController.mm
ReacherSwitcher_CFLAGS = -fobjc-arc
ReacherSwitcher_INSTALL_PATH = /Library/PreferenceBundles
ReacherSwitcher_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ReacherSwitcherSettings.plist$(ECHO_END)
