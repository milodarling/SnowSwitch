ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

BUNDLE_NAME = SnowSwitch
SnowSwitch_FILES = Switch.x VENSnowOverlayView/VENSnowOverlayView/VENSnowOverlayView.m
SnowSwitch_FRAMEWORKS = UIKit QuartzCore
SnowSwitch_LIBRARIES = flipswitch
SnowSwitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
