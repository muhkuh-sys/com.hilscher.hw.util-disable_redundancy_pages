# -*- coding: utf-8 -*-
#-------------------------------------------------------------------------#
#   Copyright (C) 2011 by Christoph Thelen                                #
#   doc_bacardi@users.sourceforge.net                                     #
#                                                                         #
#   This program is free software; you can redistribute it and/or modify  #
#   it under the terms of the GNU General Public License as published by  #
#   the Free Software Foundation; either version 2 of the License, or     #
#   (at your option) any later version.                                   #
#                                                                         #
#   This program is distributed in the hope that it will be useful,       #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#   GNU General Public License for more details.                          #
#                                                                         #
#   You should have received a copy of the GNU General Public License     #
#   along with this program; if not, write to the                         #
#   Free Software Foundation, Inc.,                                       #
#   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
#-------------------------------------------------------------------------#


#----------------------------------------------------------------------------
#
# Set up the Muhkuh Build System.
#
SConscript('mbs/SConscript')
Import('atEnv')

# Create a build environment for the Cortex-M4 based netX chips.
env_cortexM4 = atEnv.DEFAULT.CreateEnvironment(['gcc-arm-none-eabi-4.9', 'asciidoc'])
env_cortexM4.CreateCompilerEnv('NETX90_MPW', ['arch=armv7', 'thumb'], ['arch=armv7e-m', 'thumb'])

# Get the project version.
global PROJECT_VERSION



#----------------------------------------------------------------------------
#
# Build the netx90 MPW snippet.
#
sources = """
	src/disable_redundancy_pages.S
"""

tEnv = atEnv.NETX90_MPW.Clone()
tEnv.Append(CPPPATH = ['src', 'src'])
tEnv.Replace(LDFILE = 'src/netx90_mpw.ld')
tSrc = tEnv.SetBuildPath('targets', 'src', sources)
tElf = tEnv.Elf('targets/disable_redundancy_pages_netx90_mpw_intram.elf', tSrc)
tTxt = tEnv.ObjDump('targets/disable_redundancy_pages_netx90_mpw_intram.txt', tElf, OBJDUMP_FLAGS=['--disassemble', '--source', '--all-headers', '--wide'])
tBin = tEnv.ObjCopy('targets/disable_redundancy_pages_netx90_mpw_intram.bin', tElf)
tTmp = tEnv.GccSymbolTemplate('targets/snippet.xml', tElf, GCCSYMBOLTEMPLATE_TEMPLATE='templates/hboot_snippet.xml', GCCSYMBOLTEMPLATE_BINFILE=tBin[0])

# Create the snippet from the parameters.
aArtifactGroupReverse = ['com', 'hilscher', 'hw', 'util', 'netx90']
atSnippet = {
    'group': '.'.join(aArtifactGroupReverse),
    'artifact': 'disable_redundancy_pages_netx90mpw',
    'version': PROJECT_VERSION,
    'vcs_id': tEnv.Version_GetVcsIdLong(),
    'vcs_url': tEnv.Version_GetVcsUrl(),
    'license': 'GPL-2.0',
    'author_name': 'Hilscher Gesellschaft für Systemautomation',
    'author_url': 'https://github.com/muhkuh-sys',
    'description': 'Disable the redundancy pages of all Intflash units on the netX90 MPW.',
    'categories': ['netx90', 'booting', 'DPM'],
    'parameter': {
    }
}

strArtifactPath = 'targets/snippets/%s' % ('/'.join(aArtifactGroupReverse))
snippet = tEnv.HBootSnippet('%s/%s-%s.xml' % (strArtifactPath, atSnippet['artifact'], PROJECT_VERSION), tTmp, PARAMETER=atSnippet)

# Create the POM file.
tPOM = tEnv.POMTemplate('%s/%s-%s.pom' % (strArtifactPath, atSnippet['artifact'], PROJECT_VERSION), 'templates/pom.xml', POM_TEMPLATE_GROUP=atSnippet['group'], POM_TEMPLATE_ARTIFACT=atSnippet['artifact'], POM_TEMPLATE_VERSION=atSnippet['version'], POM_TEMPLATE_PACKAGING='xml')

