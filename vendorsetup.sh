#!/bin/bash

MY_DIR="${PWD}"
ASUS_LINUX_DIR="${MY_DIR}"/linux-asus-tuf-f15-2023

function regen_defconfig() {
    cd "${PWD}"
    mkdir -p "${MY_DIR}"/out
    cp "${ASUS_LINUX_DIR}"/archlinux_defconfig "${MY_DIR}"/arch/x86/configs/archlinux_defconfig
    make ARCH=x86 O=out archlinux_defconfig
    make ARCH=x86 O=out oldconfig savedefconfig
    mv -f "${MY_DIR}"/out/defconfig "${ASUS_LINUX_DIR}"/archlinux_defconfig
    cd "${ASUS_LINUX_DIR}"
}

function regen_menuconfig() {
    cd "${PWD}"
    mkdir -p "${MY_DIR}"/out
    cp "${ASUS_LINUX_DIR}"/archlinux_defconfig "${MY_DIR}"/arch/x86/configs/archlinux_defconfig
    make ARCH=x86 O=out archlinux_defconfig
    make ARCH=x86 O=out menuconfig
    make ARCH=x86 O=out oldconfig savedefconfig
    mv -f "${MY_DIR}"/out/defconfig "${ASUS_LINUX_DIR}"/archlinux_defconfig
    cd "${ASUS_LINUX_DIR}"
}

function build_kernel() {
    cd "${ASUS_LINUX_DIR}"/build
    rm -rf linux* src/ pkg/
    MAKEFLAGS="-j$(nproc)" makepkg -s --noconfirm --skippgpcheck -f
}
