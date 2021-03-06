#!/bin/bash
# $Id$

longusage() {
  echo "Gentoo Linux Genkernel ${GK_V}"
  echo
  echo "Usage: "
  echo "  genkernel [options] action"
  echo
  echo "Available Actions: "
  echo "  all				Build all steps"
  echo "  bzImage			Build only the kernel"
  echo "  initramfs			Build only the ramdisk/initramfs"
  echo "  kernel			Build only the kernel and modules"
  echo "  ramdisk			Build only the ramdisk/initramfs"
  echo
  echo "Available Options: "
  echo "  Configuration settings"
  echo "	--config=<file>	genkernel configuration file to use"
  echo "  Debug settings"
  echo "	--loglevel=<0-5>	Debug Verbosity Level"
  echo "	--logfile=<outfile>	Output file for debug info"
  echo "	--color			Output debug in color"
  echo "	--no-color		Do not output debug in color"
  echo "	--debug-cleanup		Clean up temporary build directories on exit"
  echo "	--no-debug-cleanup	Do not remove any temporary directories on exit"
  echo "  Kernel Configuration settings"
  echo "	--menuconfig		Run menuconfig after oldconfig"
  echo "	--no-menuconfig		Do not run menuconfig after oldconfig"
  echo "	--nconfig		Run nconfig after oldconfig"
  echo "	--no-nconfig		Do not run nconfig after oldconfig"
  echo "	--gconfig		Run gconfig after oldconfig"
  echo "	--no-gconfig		Don't run gconfig after oldconfig"
  echo "	--xconfig		Run xconfig after oldconfig"
  echo "	--no-xconfig		Don't run xconfig after oldconfig"
  echo "	--save-config		Save the configuration to /etc/kernels"
  echo "	--no-save-config	Don't save the configuration to /etc/kernels"
  echo "	--hyperv		Enable Microsoft Hyper-V kernel options in kernel"
  echo "	--no-hyperv		Don't enable Microsoft Hyper-V kernel options in kernel"
  echo "	--microcode[=<type>]	Enable early microcode support in kernel configuration,"
  echo "				'all' for all, 'amd' for AMD and 'intel' for Intel CPU types."
  echo "	--no-microcode		Don't enable early microcode support in kernel configuration"
  echo "	--virtio		Enable VirtIO kernel options in kernel"
  echo "	--no-virtio		Don't enable VirtIO kernel options in kernel"
  echo "  Kernel Compile settings"
  echo "	--oldconfig		Implies --no-clean and runs a 'make oldconfig'"
  echo "	--clean			Run make clean before compilation"
  echo "	--no-clean		Do not run make clean before compilation"
  echo "	--mrproper		Run make mrproper before compilation"
  echo "	--no-mrproper		Do not run make mrproper before compilation"
  echo "	--splash		Install framebuffer splash support into initramfs"
  echo "	--no-splash		Do not install framebuffer splash"
  echo "	--install		Install the kernel after building"
  echo "	--no-install		Do not install the kernel after building"
  echo "	--symlink		Manage symlinks in /boot for installed images"
  echo "	--no-symlink		Do not manage symlinks"
  echo "	--ramdisk-modules	Copy required modules to the ramdisk"
  echo "	--no-ramdisk-modules	Don't copy any modules to the ramdisk"
  echo "	--all-ramdisk-modules	Copy all kernel modules to the ramdisk"
  echo "	--callback=<...>	Run the specified arguments after the"
  echo "				kernel and modules have been compiled"
  echo "	--static		Build a static (monolithic kernel)."
  echo "	--no-static		Do not build a static (monolithic kernel)."
  echo "  Kernel settings"
  echo "	--kerneldir=<dir>	Location of the kernel sources"
  echo "	--kernel-config=<file|default>"
  echo "				Kernel configuration file to use for compilation."
  echo "				Use 'default' to explicitly start from scratch"
  echo "				using genkernel defaults."
  echo "	--module-prefix=<dir>	Prefix to kernel module destination, modules"
  echo "				will be installed in <prefix>/lib/modules"
  echo "  Low-Level Compile settings"
  echo "	--kernel-cc=<compiler>	Compiler to use for kernel (e.g. distcc)"
  echo "	--kernel-as=<assembler>	Assembler to use for kernel"
  echo "	--kernel-ld=<linker>	Linker to use for kernel"
  echo "	--kernel-cross-compile=<cross var>"
  echo "				CROSS_COMPILE kernel variable"
  echo "	--kernel-make=<makeprg> GNU Make to use for kernel"
  echo "	--kernel-target=<t>	Override default make target (bzImage)"
  echo "	--kernel-binary=<path>	Override default kernel binary path (arch/foo/boot/bar)"
  echo "	--kernel-outputdir=<path>"
  echo "				Save output files outside the source tree."

  echo "	--utils-cc=<compiler>	Compiler to use for utilities"
  echo "	--utils-as=<assembler>	Assembler to use for utils"
  echo "	--utils-ld=<linker>	Linker to use for utils"
  echo "	--utils-make=<makeprog>	GNU Make to use for utils"
  echo "	--utils-cross-compile=<cross var>"
  echo "				CROSS_COMPILE utils variable"
  echo "	--utils-arch=<arch> 	Force to arch for utils only instead of"
  echo "				autodetect."
  echo "	--makeopts=<makeopts>	Make options such as -j2, etc..."
  echo "	--mountboot		Mount BOOTDIR automatically if mountable"
  echo "	--no-mountboot		Don't mount BOOTDIR automatically"
  echo "	--bootdir=<dir>		Set the location of the boot-directory, default is /boot"
  echo "	--modprobedir=<dir>	Set the location of the modprobe.d-directory, default is /etc/modprobe.d"
  echo "	--nice			Run the kernel make at the default nice level (10)."
  echo "	--nice=<0-19>		Run the kernel make at the selected nice level."
  echo "	--no-nice		Don't be nice while running the kernel make."
  echo "  Initialization"
  echo "	--splash=<theme>	Enable framebuffer splash using <theme>"
  echo "	--splash-res=<res>	Select splash theme resolutions to install"
  echo "	--splash=<theme>	Enable framebuffer splash using <theme>"
  echo "	--splash-res=<res>	Select splash theme resolutions to install"
  echo "	--do-keymap-auto	Forces keymap selection at boot"
  echo "	--keymap		Enables keymap selection support"
  echo "	--no-keymap		Disables keymap selection support"
  echo "	--lvm			Include LVM support"
  echo "	--no-lvm		Exclude LVM support"
  echo "	--mdadm			Include MDADM/MDMON support"
  echo "	--no-mdadm		Exclude MDADM/MDMON support"
  echo "	--mdadm-config=<file>	Use file as mdadm.conf in initramfs"
  echo "	--microcode-initramfs	Prepend early microcode to initramfs"
  echo "	--no-microcode-initramfs"
  echo "				Don't prepend early microcode to initramfs"
  echo "	--nfs			Include NFS support"
  echo "	--no-nfs		Exclude NFS support"
  echo "	--dmraid		Include DMRAID support"
  echo "	--no-dmraid		Exclude DMRAID support"
  echo "	--e2fsprogs		Include e2fsprogs"
  echo "	--no-e2fsprogs		Exclude e2fsprogs"
  echo "	--zfs			Include ZFS support (enabled by default if rootfs is ZFS)"
  echo "	--no-zfs		Exclude ZFS support"
  echo "	--btrfs			Include Btrfs support (enabled by default if rootfs is Btrfs)"
  echo "	--no-btrfs		Exclude Btrfs support"
  echo "	--multipath		Include Multipath support"
  echo "	--no-multipath		Exclude Multipath support"
  echo "	--iscsi			Include iSCSI support"
  echo "	--no-iscsi		Exclude iSCSI support"
  echo "	--ssh			Include SSH (dropbear) support"
  echo "	--no-ssh		Exclude SSH (dropbear) support"
  echo "	--bootloader=(grub|grub2)"
  echo "				Add new kernel to GRUB (grub) or GRUB2 (grub2) bootloader"
  echo "	--no-bootloader		Skip bootloader update"
  echo "	--linuxrc=<file>	Specifies a user created linuxrc"
  echo "	--busybox-config=<file>	Specifies a user created busybox config"
  echo "	--genzimage		Make and install kernelz image (PowerPC)"
  echo "	--disklabel		Include disk label and uuid support in your ramdisk"
  echo "	--no-disklabel		Exclude disk label and uuid support in your ramdisk"
  echo "	--luks			Include LUKS support"
  echo "	--no-luks		Exclude LUKS support"
  echo "	--gpg			Include GPG-armored LUKS key support"
  echo "	--no-gpg		Exclude GPG-armored LUKS key support"
  echo "	--busybox		Include busybox"
  echo "	--no-busybox		Exclude busybox"
  echo "	--unionfs		Include support for unionfs"
  echo "	--no-unionfs		Exclude support for unionfs"
  echo "	--netboot		Create a self-contained env in the initramfs"
  echo "	--no-netboot		Exclude netboot env"
  echo "	--real-root=<foo>	Specify a default for real_root="
  echo "  Internals"
  echo "	--arch-override=<arch>	Force to arch instead of autodetect"
  echo "	--cachedir=<dir>	Override the default cache location"
  echo "	--clear-cachedir	Clear genkernel's cache location on start. Useful"
  echo "				if you want to force rebuild of included tools"
  echo "				like BusyBox, DMRAID, GnuPG, LVM, MDADM ..."
  echo "	--no-clear-cachedir	Do not clean up on genkernel start"
  echo "	--tempdir=<dir>		Location of genkernel's temporary directory"
  echo "	--postclear		Clear all tmp files and caches after genkernel has run"
  echo "	--no-postclear		Do not clean up after genkernel has run"
  echo "  Output Settings"
  echo "	--kernname=<...>	Tag the kernel and ramdisk with a name:"
  echo "				If not defined the option defaults to"
  echo "				'genkernel'"
  echo "	--minkernpackage=<tbz2>	File to output a .tar.bz2'd kernel and ramdisk:"
  echo "				No modules outside of the ramdisk will be"
  echo "				included..."
  echo "	--modulespackage=<tbz2>	File to output a .tar.bz2'd modules after the"
  echo "				callbacks have run"
  echo "	--kerncache=<tbz2>	File to output a .tar.bz2'd kernel contents"
  echo "				of /lib/modules/ and the kernel config"
  echo "				NOTE: This is created before the callbacks"
  echo "				are run!"
  echo "	--no-kernel-sources	This option is only valid if kerncache is"
  echo "				defined. If there is a valid kerncache no checks"
  echo "				will be made against a kernel source tree"
  echo "	--initramfs-overlay=<dir>"
  echo "				Directory structure to include in the initramfs,"
  echo "				only available on 2.6 kernels"
  echo "	--firmware		Enable copying of firmware into initramfs"
  echo "	--firmware-dir=<dir>"
  echo "				Specify directory to copy firmware from (defaults"
  echo "				to /lib/firmware)"
  echo "	--firmware-files=<files>"
  echo "				Specifies specific firmware files to copy. This"
  echo "				overrides --firmware-dir. For multiple files,"
  echo "				separate the filenames with a comma"
  echo "	--firmware-install	Enable installing firmware onto root filesystem"
  echo "				(only available for kernels older than v4.14)"
  echo "	--integrated-initramfs"
  echo "				Include the generated initramfs in the kernel"
  echo "				instead of keeping it as a separate file"
  echo "	--no-integrated-initramfs"
  echo "				Do not include the generated initramfs in the kernel"
  echo "	--wrap-initrd		Wrap initramfs using mkimage for u-boot boots"
  echo "	 --no-wrap-initrd	Do not wrap initramfs using mkimage for u-boot boots"
  echo "	--compress-initramfs"
  echo "				Compress initramfs"
  echo "	--no-compress-initramfs"
  echo "				Do not compress initramfs"
  echo "	--compress-initrd	Deprecated alias for --compress-initramfs"
  echo "	--no-compress-initrd	Deprecated alias for --no-compress-initramfs"
  echo "	--compress-initramfs-type=<arg>"
  echo "				Compression type for initramfs (best, xz, lzma, bzip2, gzip, lzop)"
  echo "	--strip=(all|kernel|modules|none)"
  echo "				Strip debug symbols from none, all, installed kernel (obsolete) or"
  echo "				modules (default)."
  echo "	--no-strip		Don't strip installed kernel or modules, alias for --strip=none"
  echo
  echo "For a detailed list of supported initramfs options and flags; issue:"
  echo "	man 8 genkernel"
}

usage() {
  echo "Gentoo Linux Genkernel ${GK_V}"
  echo
  echo "Usage: "
  echo "	genkernel [options] (all|bzImage|initramfs|kernel)"
  echo
  echo 'Some useful options:'
  echo '	--menuconfig		Run menuconfig after oldconfig'
  echo '	--nconfig		Run nconfig after oldconfig (requires ncurses)'
  echo '	--no-clean		Do not run make clean before compilation'
  echo '	--no-mrproper		Do not run make mrproper before compilation,'
  echo '				this is implied by --no-clean.'
  echo
  echo 'For a detailed list of supported commandline options and flags; issue:'
  echo '	genkernel --help'
  echo 'For a detailed list of supported initramfs options and flags; issue:'
  echo '	man 8 genkernel'
}

parse_optbool() {
	local opt=${1/--no-*/no} # false
	opt=${opt/--*/yes} # true
	echo $opt
}

parse_cmdline() {
	case "$*" in
		--kernel-cc=*)
			CMD_KERNEL_CC="${*#*=}"
			print_info 2 "CMD_KERNEL_CC: ${CMD_KERNEL_CC}"
			;;
		--kernel-ld=*)
			CMD_KERNEL_LD="${*#*=}"
			print_info 2 "CMD_KERNEL_LD: ${CMD_KERNEL_LD}"
			;;
		--kernel-as=*)
			CMD_KERNEL_AS="${*#*=}"
			print_info 2 "CMD_KERNEL_AS: ${CMD_KERNEL_AS}"
			;;
		--kernel-make=*)
			CMD_KERNEL_MAKE="${*#*=}"
			print_info 2 "CMD_KERNEL_MAKE: ${CMD_KERNEL_MAKE}"
			;;
		--kernel-target=*)
			KERNEL_MAKE_DIRECTIVE_OVERRIDE="${*#*=}"
			print_info 2 "KERNEL_MAKE_DIRECTIVE_OVERRIDE: ${KERNEL_MAKE_DIRECTIVE_OVERRIDE}"
			;;
		--kernel-binary=*)
			KERNEL_BINARY_OVERRIDE="${*#*=}"
			print_info 2 "KERNEL_BINARY_OVERRIDE: ${KERNEL_BINARY_OVERRIDE}"
			;;
		--kernel-cross-compile=*)
			CMD_KERNEL_CROSS_COMPILE="${*#*=}"
			CMD_KERNEL_CROSS_COMPILE=$(echo ${CMD_KERNEL_CROSS_COMPILE}|sed -e 's/.*[^-]$/&-/g')
			print_info 2 "CMD_KERNEL_CROSS_COMPILE: ${CMD_KERNEL_CROSS_COMPILE}"
			;;
		--kernel-outputdir=*)
			CMD_KERNEL_OUTPUTDIR="${*#*=}"
			print_info 2 "CMD_KERNEL_OUTPUTDIR: ${CMD_KERNEL_OUTPUTDIR}"
			;;
		--utils-cc=*)
			CMD_UTILS_CC="${*#*=}"
			print_info 2 "CMD_UTILS_CC: ${CMD_UTILS_CC}"
			;;
		--utils-ld=*)
			CMD_UTILS_LD="${*#*=}"
			print_info 2 "CMD_UTILS_LD: ${CMD_UTILS_LD}"
			;;
		--utils-as=*)
			CMD_UTILS_AS="${*#*=}"
			print_info 2 "CMD_UTILS_AS: ${CMD_UTILS_AS}"
			;;
		--utils-make=*)
			CMD_UTILS_MAKE="${*#*=}"
			print_info 2 "CMD_UTILS_MAKE: ${CMD_UTILS_MAKE}"
			;;
		--utils-cross-compile=*)
			CMD_UTILS_CROSS_COMPILE="${*#*=}"
			CMD_UTILS_CROSS_COMPILE=$(echo ${CMD_UTILS_CROSS_COMPILE}|sed -e 's/.*[^-]$/&-/g')
			print_info 2 "CMD_UTILS_CROSS_COMPILE: ${CMD_UTILS_CROSS_COMPILE}"
			;;
		--utils-arch=*)
			CMD_UTILS_ARCH="${*#*=}"
			print_info 2 "CMD_UTILS_ARCH: ${CMD_ARCHOVERRIDE}"
			;;
		--makeopts=*)
			CMD_MAKEOPTS="${*#*=}"
			print_info 2 "CMD_MAKEOPTS: ${CMD_MAKEOPTS}"
			;;
		--mountboot|--no-mountboot)
			CMD_MOUNTBOOT=`parse_optbool "$*"`
			print_info 2 "CMD_MOUNTBOOT: ${CMD_MOUNTBOOT}"
			;;
		--bootdir=*)
			CMD_BOOTDIR="${*#*=}"
			print_info 2 "CMD_BOOTDIR: ${CMD_BOOTDIR}"
			;;
		--modprobedir=*)
			CMD_MODPROBEDIR="${*#*=}"
			print_info 2 "CMD_MODPROBEDIR: ${CMD_MODPROBEDIR}"
			;;
		--do-keymap-auto)
			CMD_DOKEYMAPAUTO="yes"
			CMD_KEYMAP="yes"
			print_info 2 "CMD_DOKEYMAPAUTO: ${CMD_DOKEYMAPAUTO}"
			;;
		--keymap|--no-keymap)
			CMD_KEYMAP=`parse_optbool "$*"`
			print_info 2 "CMD_KEYMAP: ${CMD_KEYMAP}"
			;;
		--lvm|--no-lvm)
			CMD_LVM=`parse_optbool "$*"`
			print_info 2 "CMD_LVM: ${CMD_LVM}"
			;;
		--lvm2|--no-lvm2)
			CMD_LVM=`parse_optbool "$*"`
			print_info 2 "CMD_LVM: ${CMD_LVM}"
			echo
			print_warning 1 "Please use --lvm, as --lvm2 is deprecated."
			;;
		--mdadm|--no-mdadm)
			CMD_MDADM=`parse_optbool "$*"`
			print_info 2 "CMD_MDADM: $CMD_MDADM"
			if isTrue "${CMD_MDADM}" && [ ! -e /sbin/mdadm ]
			then
				print_warning 'Warning: --mdadm generally requires sys-fs/mdadm present on the host system'
			fi
			;;
		--mdadm-config=*)
			CMD_MDADM_CONFIG="${*#*=}"
			print_info 2 "CMD_MDADM_CONFIG: $CMD_MDADM_CONFIG"
			;;
		--busybox|--no-busybox)
			CMD_BUSYBOX=`parse_optbool "$*"`
			print_info 2 "CMD_BUSYBOX: ${CMD_BUSYBOX}"
			;;
		--microcode|--no-microcode)
			case `parse_optbool "$*"` in
				no)  CMD_MICROCODE='no' ;;
				yes) CMD_MICROCODE='all' ;;
			esac
			print_info 2 "CMD_MICROCODE: ${CMD_MICROCODE}"
			;;
		--microcode=*)
			CMD_MICROCODE="${*#*=}"
			print_info 2 "CMD_MICROCODE: $CMD_MICROCODE"
			;;
		--microcode-initramfs|--no-microcode-initramfs)
			CMD_MICROCODE_INITRAMFS=`parse_optbool "$*"`
			print_info 2 "CMD_MICROCODE_INITRAMFS: ${CMD_MICROCODE_INITRAMFS}"
			;;
		--nfs|--no-nfs)
			CMD_NFS=`parse_optbool "$*"`
			print_info 2 "CMD_NFS: ${CMD_NFS}"
			;;
		--unionfs|--no-unionfs)
			CMD_UNIONFS=`parse_optbool "$*"`
			print_info 2 "CMD_UNIONFS: ${CMD_UNIONFS}"
			;;
		--netboot|--no-netboot)
			CMD_NETBOOT=`parse_optbool "$*"`
			print_info 2 "CMD_NETBOOT: ${CMD_NETBOOT}"
			;;
		--real-root=*)
			CMD_REAL_ROOT="${*#*=}"
			print_info 2 "CMD_REAL_ROOT: ${CMD_REAL_ROOT}"
			;;
		--dmraid|--no-dmraid)
			CMD_DMRAID=`parse_optbool "$*"`
			if isTrue "${CMD_DMRAID}" && [ ! -e /usr/sbin/dmraid ]
			then
				echo 'Error: --dmraid requires sys-fs/dmraid' \
					'to be installed on the host system.'
				exit 1
			fi
			if isTrue "${CMD_DMRAID}" && [ ! -e /usr/include/libdevmapper.h ]
			then
				echo 'Error: --dmraid requires sys-fs/lvm2' \
					'to be installed on the host system.'
				exit 1
			fi
			print_info 2 "CMD_DMRAID: ${CMD_DMRAID}"
			;;
		--e2fsprogs|--no-e2fsprogs)
			CMD_E2FSPROGS=`parse_optbool "$*"`
			print_info 2 "CMD_E2FSPROGS: ${CMD_E2FSPROGS}"
			;;
		--zfs|--no-zfs)
			CMD_ZFS=`parse_optbool "$*"`
			print_info 2 "CMD_ZFS: ${CMD_ZFS}"
			;;
		--btrfs|--no-btrfs)
			CMD_BTRFS=`parse_optbool "$*"`
			print_info 2 "CMD_BTRFS: ${CMD_BTRFS}"
			;;
		--virtio|--no-virtio)
			CMD_VIRTIO=`parse_optbool "$*"`
			print_info 2 "CMD_VIRTIO: ${CMD_VIRTIO}"
			;;
		--multipath|--no-multipath)
			CMD_MULTIPATH=`parse_optbool "$*"`
			if isTrue "${CMD_MULTIPATH}" && [ ! -e /sbin/multipath ]
			then
				echo 'Error: --multipath requires sys-fs/multipath-tools' \
					'to be installed on the host system.'
				exit 1
			fi
			if isTrue "${CMD_MULTIPATH}" && [ ! -e /usr/include/libdevmapper.h ]
			then
				echo 'Error: --multipath requires sys-fs/lvm2' \
					'to be installed on the host system.'
				exit 1
			fi
			print_info 2 "CMD_MULTIPATH: ${CMD_MULTIPATH}"
			;;
		--bootloader=*)
			CMD_BOOTLOADER="${*#*=}"
			[ -z "${CMD_BOOTLOADER}" ] && CMD_BOOTLOADER="no"
			case "${CMD_BOOTLOADER}" in
				no|grub|grub2)
					;;
				*)
					echo "Error: Bootloader '${CMD_BOOTLOADER}' is unsupported."
					exit 1
			esac
			print_info 2 "CMD_BOOTLOADER: ${CMD_BOOTLOADER}"
			;;
		--no-bootloader)
			CMD_BOOTLOADER="no"
			print_info 2 "CMD_BOOTLOADER: ${CMD_BOOTLOADER}"
			;;
		--iscsi|--no-iscsi)
			CMD_ISCSI=`parse_optbool "$*"`
			print_info 2 "CMD_ISCSI: ${CMD_ISCSI}"
			;;
		--hyperv|--no-hyperv)
			CMD_HYPERV=`parse_optbool "$*"`
			print_info 2 "CMD_HYPERV: ${CMD_HYPERV}"
			;;
		--ssh|--no-ssh)
			CMD_SSH=`parse_optbool "$*"`
			print_info 2 "CMD_SSH: ${CMD_SSH}"
			if isTrue "${CMD_SSH}" && [ ! -e /usr/sbin/dropbear ]
			then
				echo 'Error: --ssh requires net-misc/dropbear' \
					'to be installed on the host system.'
				exit 1
			fi
			if isTrue "${CMD_SSH}" && [ ! -e /etc/dropbear/authorized_keys ]
			then
				echo 'Error: --ssh requires that dropbear is configured' \
					'but /etc/dropbear/authorized_keys does not exist!'
				exit 1
			fi
			;;
		--loglevel=*)
			CMD_LOGLEVEL="${*#*=}"
			LOGLEVEL="${CMD_LOGLEVEL}"
			print_info 2 "CMD_LOGLEVEL: ${CMD_LOGLEVEL}"
			;;
		--menuconfig)
			TERM_LINES=`stty -a | head -n 1 | cut -d\  -f5 | cut -d\; -f1`
			TERM_COLUMNS=`stty -a | head -n 1 | cut -d\  -f7 | cut -d\; -f1`
			if [[ TERM_LINES -lt 19 || TERM_COLUMNS -lt 80 ]]
			then
				echo 'Error: You need a terminal with at least 80 columns' \
					'and 19 lines for --menuconfig; try --no-menuconfig...'
				exit 1
			fi
			CMD_MENUCONFIG="yes"
			print_info 2 "CMD_MENUCONFIG: ${CMD_MENUCONFIG}"
			;;
		--no-menuconfig)
			CMD_MENUCONFIG="no"
			print_info 2 "CMD_MENUCONFIG: ${CMD_MENUCONFIG}"
			;;
		--nconfig)
			TERM_LINES=`stty -a | head -n 1 | cut -d\  -f5 | cut -d\; -f1`
			TERM_COLUMNS=`stty -a | head -n 1 | cut -d\  -f7 | cut -d\; -f1`
			if [[ TERM_LINES -lt 19 || TERM_COLUMNS -lt 80 ]]
			then
				echo 'Error: You need a terminal with at least 80 columns' \
					'and 19 lines for --nconfig; try --no-nconfig...'
				exit 1
			fi
			CMD_NCONFIG="yes"
			print_info 2 "CMD_NCONFIG: ${CMD_NCONFIG}"
			;;
		--no-nconfig)
			CMD_NCONFIG="no"
			print_info 2 "CMD_NCONFIG: ${CMD_NCONFIG}"
			;;
		--gconfig|--no-gconfig)
			CMD_GCONFIG=`parse_optbool "$*"`
			print_info 2 "CMD_GCONFIG: ${CMD_GCONFIG}"
			;;
		--xconfig|--no-xconfig)
			CMD_XCONFIG=`parse_optbool "$*"`
			print_info 2 "CMD_XCONFIG: ${CMD_XCONFIG}"
			;;
		--save-config|--no-save-config)
			CMD_SAVE_CONFIG=`parse_optbool "$*"`
			print_info 2 "CMD_SAVE_CONFIG: ${CMD_SAVE_CONFIG}"
			;;
		--mrproper|--no-mrproper)
			CMD_MRPROPER=`parse_optbool "$*"`
			print_info 2 "CMD_MRPROPER: ${CMD_MRPROPER}"
			;;
		--clean|--no-clean)
			CMD_CLEAN=`parse_optbool "$*"`
			print_info 2 "CMD_CLEAN: ${CMD_CLEAN}"
			;;
		--oldconfig|--no-oldconfig)
			CMD_OLDCONFIG=`parse_optbool "$*"`
			isTrue "${CMD_OLDCONFIG}" && CMD_CLEAN="no"
			print_info 2 "CMD_CLEAN: ${CMD_CLEAN}"
			print_info 2 "CMD_OLDCONFIG: ${CMD_OLDCONFIG}"
			;;
		--gensplash=*)
			CMD_SPLASH="yes"
			SPLASH_THEME="${*#*=}"
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			print_info 2 "SPLASH_THEME: ${SPLASH_THEME}"
			echo
			print_warning 1 "Please use --splash, as --gensplash is deprecated."
			;;
		--gensplash|--no-gensplash)
			CMD_SPLASH=`parse_optbool "$*"`
			SPLASH_THEME='default'
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			echo
			print_warning 1 "Please use --splash, as --gensplash is deprecated."
			;;
		--splash=*)
			CMD_SPLASH="yes"
			SPLASH_THEME="${*#*=}"
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			print_info 2 "SPLASH_THEME: ${SPLASH_THEME}"
			;;
		--splash|--no-splash)
			CMD_SPLASH=`parse_optbool "$*"`
			SPLASH_THEME='default'
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			;;
		--gensplash-res=*)
			SPLASH_RES="${*#*=}"
			print_info 2 "SPLASH_RES: ${SPLASH_RES}"
			echo
			print_warning 1 "Please use --splash-res, as --gensplash-res is deprecated."
			;;
		--splash-res=*)
			SPLASH_RES="${*#*=}"
			print_info 2 "SPLASH_RES: ${SPLASH_RES}"
			;;
		--install|--no-install)
			CMD_INSTALL=`parse_optbool "$*"`
			print_info 2 "CMD_INSTALL: ${CMD_INSTALL}"
			;;
		--ramdisk-modules|--no-ramdisk-modules)
			CMD_RAMDISKMODULES=`parse_optbool "$*"`
			print_info 2 "CMD_RAMDISKMODULES: ${CMD_RAMDISKMODULES}"
			;;
		--all-ramdisk-modules|--no-all-ramdisk-modules)
			CMD_ALLRAMDISKMODULES=`parse_optbool "$*"`
			print_info 2 "CMD_ALLRAMDISKMODULES: ${CMD_ALLRAMDISKMODULES}"
			;;
		--callback=*)
			CMD_CALLBACK="${*#*=}"
			print_info 2 "CMD_CALLBACK: ${CMD_CALLBACK}/$*"
			;;
		--static|--no-static)
			CMD_STATIC=`parse_optbool "$*"`
			print_info 2 "CMD_STATIC: ${CMD_STATIC}"
			;;
		--tempdir=*)
			TMPDIR="${*#*=}"
			TEMP=$(mktemp -d -p "${TMPDIR}" gk.XXXXXXXX)
			print_info 2 "TMPDIR: ${TMPDIR}"
			print_info 2 "TEMP: ${TEMP}"
			;;
		--postclear|--no-postclear)
			CMD_POSTCLEAR=`parse_optbool "$*"`
			print_info 2 "CMD_POSTCLEAR: ${CMD_POSTCLEAR}"
			;;
		--arch-override=*)
			CMD_ARCHOVERRIDE="${*#*=}"
			print_info 2 "CMD_ARCHOVERRIDE: ${CMD_ARCHOVERRIDE}"
			;;
		--color|--no-color)
			USECOLOR=`parse_optbool "$*"`
			print_info 2 "USECOLOR: ${USECOLOR}"
			setColorVars
			;;
		--debug-cleanup|--no-debug-cleanup)
			CMD_DEBUGCLEANUP=`parse_optbool "$*"`
			print_info 2 "CMD_DEBUGCLEANUP: ${CMD_DEBUGCLEANUP}"
			;;
		--logfile=*)
			CMD_LOGFILE="${*#*=}"
			LOGFILE="${*#*=}"
			print_info 2 "CMD_LOGFILE: ${CMD_LOGFILE}"
			print_info 2 "LOGFILE: ${CMD_LOGFILE}"
			;;
		--kerneldir=*)
			CMD_KERNEL_DIR="${*#*=}"
			print_info 2 "CMD_KERNEL_DIR: ${CMD_KERNEL_DIR}"
			;;
		--kernel-config=*)
			CMD_KERNEL_CONFIG="${*#*=}"
			print_info 2 "CMD_KERNEL_CONFIG: ${CMD_KERNEL_CONFIG}"
			;;
		--module-prefix=*)
			CMD_INSTALL_MOD_PATH="${*#*=}"
			print_info 2 "CMD_INSTALL_MOD_PATH: ${CMD_INSTALL_MOD_PATH}"
			;;
		--cachedir=*)
			CACHE_DIR="${*#*=}"
			print_info 2 "CACHE_DIR: ${CACHE_DIR}"
			;;
		--clear-cachedir|--no-clear-cachedir)
			CMD_CLEAR_CACHEDIR=`parse_optbool "$*"`
			print_info 2 "CMD_CLEAR_CACHEDIR: ${CMD_CLEAR_CACHEDIR}"
			;;
		--minkernpackage=*)
			CMD_MINKERNPACKAGE="${*#*=}"
			[ ${CMD_MINKERNPACKAGE:0:1} != / ] && CMD_MINKERNPACKAGE=$PWD/$CMD_MINKERNPACKAGE
			print_info 2 "MINKERNPACKAGE: ${CMD_MINKERNPACKAGE}"
			;;
		--modulespackage=*)
			CMD_MODULESPACKAGE="${*#*=}"
			[ ${CMD_MODULESPACKAGE:0:1} != / ] && CMD_MODULESPACKAGE=$PWD/$CMD_MODULESPACKAGE
			print_info 2 "MODULESPACKAGE: ${CMD_MODULESPACKAGE}"
			;;
		--kerncache=*)
			CMD_KERNCACHE="${*#*=}"
			[ ${CMD_KERNCACHE:0:1} != / ] && CMD_KERNCACHE=$PWD/$CMD_KERNCACHE
			print_info 2 "KERNCACHE: ${CMD_KERNCACHE}"
			;;
		--kernname=*)
			CMD_KERNNAME="${*#*=}"
			print_info 2 "KERNNAME: ${CMD_KERNNAME}"
			;;
		--symlink|--no-symlink)
			CMD_SYMLINK=`parse_optbool "$*"`
			print_info 2 "CMD_SYMLINK: ${CMD_SYMLINK}"
			;;
		--kernel-sources|--no-kernel-sources)
			CMD_KERNEL_SOURCES=`parse_optbool "$*"`
			print_info 2 "CMD_KERNEL_SOURCES: ${CMD_KERNEL_SOURCES}"
			;;
		--initramfs-overlay=*)
			CMD_INITRAMFS_OVERLAY="${*#*=}"
			print_info 2 "CMD_INITRAMFS_OVERLAY: ${CMD_INITRAMFS_OVERLAY}"
			;;
		--linuxrc=*)
			CMD_LINUXRC="${*#*=}"
			print_info 2 "CMD_LINUXRC: ${CMD_LINUXRC}"
			;;
		--busybox-config=*)
			CMD_BUSYBOX_CONFIG="${*#*=}"
			print_info 2 "CMD_BUSYBOX_CONFIG: ${CMD_BUSYBOX_CONFIG}"
			;;
		--genzimage)
			KERNEL_MAKE_DIRECTIVE_2='zImage.initrd'
			KERNEL_BINARY_2='arch/powerpc/boot/zImage.initrd'
			CMD_GENZIMAGE="yes"
			print_info 2 "CMD_GENZIMAGE: ${CMD_GENZIMAGE}"
#			ENABLE_PEGASOS_HACKS="yes"
#			print_info 2 "ENABLE_PEGASOS_HACKS: ${ENABLE_PEGASOS_HACKS}"
			;;
		--disklabel|--no-disklabel)
			CMD_DISKLABEL=`parse_optbool "$*"`
			print_info 2 "CMD_DISKLABEL: ${CMD_DISKLABEL}"
			;;
		--luks|--no-luks)
			CMD_LUKS=`parse_optbool "$*"`
			print_info 2 "CMD_LUKS: ${CMD_LUKS}"
			;;
		--gpg|--no-gpg)
			CMD_GPG=`parse_optbool "$*"`
			print_info 2 "CMD_GPG: ${CMD_GPG}"
			;;
		--firmware|--no-firmware)
			CMD_FIRMWARE=`parse_optbool "$*"`
			print_info 2 "CMD_FIRMWARE: ${CMD_FIRMWARE}"
			;;
		--firmware-dir=*)
			CMD_FIRMWARE_DIR="${*#*=}"
			CMD_FIRMWARE="yes"
			print_info 2 "CMD_FIRMWARE_DIR: ${CMD_FIRMWARE_DIR}"
			;;
		--firmware-files=*)
			CMD_FIRMWARE_FILES="${*#*=}"
			CMD_FIRMWARE="yes"
			print_info 2 "CMD_FIRMWARE_FILES: ${CMD_FIRMWARE_FILES}"
			;;
		--firmware-install|--no-firmware-install)
			CMD_FIRMWARE_INSTALL=`parse_optbool "$*"`
			print_info 2 "CMD_FIRMWARE_INSTALL: ${CMD_FIRMWARE_INSTALL}"
			;;
		--integrated-initramfs|--no-integrated-initramfs)
			CMD_INTEGRATED_INITRAMFS=`parse_optbool "$*"`
			print_info 2 "CMD_INTEGRATED_INITRAMFS=${CMD_INTEGRATED_INITRAMFS}"
			;;
		--wrap-initrd|--no-wrap-initrd)
			CMD_WRAP_INITRD=`parse_optbool "$*"`
			print_info 2 "CMD_WRAP_INITRD=${CMD_WRAP_INITRD}"
			;;
		--compress-initramfs|--no-compress-initramfs)
			CMD_COMPRESS_INITRD=`parse_optbool "$*"`
			print_info 2 "CMD_COMPRESS_INITRD=${CMD_COMPRESS_INITRD}"
			;;
		--compress-initrd|--no-compress-initrd)
			CMD_COMPRESS_INITRD=`parse_optbool "$*"`
			print_info 2 "CMD_COMPRESS_INITRD=${CMD_COMPRESS_INITRD}"
			echo
			print_warning 1 "Please use --[no-]compress-initramfs, as --[no-]compress-initrd is deprecated."
			;;
		--compress-initramfs-type=*|--compress-initrd-type=*)
			CMD_COMPRESS_INITRD_TYPE="${*#*=}"
			print_info 2 "CMD_COMPRESS_INITRD_TYPE: ${CMD_COMPRESS_INITRD_TYPE}"
			;;
		--config=*)
			print_info 2 "CMD_GK_CONFIG: "${*#*=}""
			;;
		--nice)
			CMD_NICE=10
			print_info 2 "CMD_NICE: ${CMD_NICE}"
			;;
		--nice=*)
			CMD_NICE="${*#*=}"
			if [ ${CMD_NICE} -lt 0 -o ${CMD_NICE} -gt 19 ]
			then
				echo 'Error:  Illegal value specified for --nice= parameter.'
				exit 1
			fi
			print_info 2 "CMD_NICE: ${CMD_NICE}"
			;;
		--no-nice)
			CMD_NICE=0
			print_info 2 "CMD_NICE: ${CMD_NICE}"
			;;
		--strip=*)
			CMD_STRIP_TYPE=`parse_opt "$*"`
			print_info 2 "CMD_STRIP_TYPE: ${CMD_STRIP_TYPE}"
			;;
		--no-strip)
			CMD_STRIP_TYPE=none
			print_info 2 "CMD_STRIP_TYPE: ${CMD_STRIP_TYPE}"
			;;
		all)
			BUILD_KERNEL="yes"
			BUILD_MODULES="yes"
			BUILD_RAMDISK="yes"
			;;
		ramdisk|initramfs)
			BUILD_KERNEL="no"
			BUILD_MODULES="no"
			BUILD_RAMDISK="yes"
			;;
		kernel)
			BUILD_KERNEL="yes"
			BUILD_MODULES="yes"
			BUILD_RAMDISK="no"
			;;
		bzImage)
			BUILD_KERNEL="yes"
			BUILD_MODULES="no"
			BUILD_RAMDISK="no"
			CMD_RAMDISKMODULES="no"
			print_info 2 "CMD_RAMDISKMODULES: ${CMD_RAMDISKMODULES}"
			;;
		--help)
			longusage
			exit 1
			;;
		--version)
			echo "${GK_V}"
			exit 0
			;;
		*)
			echo "Error: Unknown option '$*'!"
			exit 1
			;;
	esac
}
