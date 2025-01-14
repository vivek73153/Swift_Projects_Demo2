import CoreFoundation.CFArray
import CoreFoundation.CFAttributedString
import CoreFoundation.CFBag
import CoreFoundation.CFBase
import CoreFoundation.CFBinaryHeap
import CoreFoundation.CFBitVector
import CoreFoundation.CFBundle
import CoreFoundation.CFByteOrder
import CoreFoundation.CFCalendar
import CoreFoundation.CFCharacterSet
import CoreFoundation.CFData
import CoreFoundation.CFDate
import CoreFoundation.CFDateFormatter
import CoreFoundation.CFDictionary
import CoreFoundation.CFError
import CoreFoundation.CFFileDescriptor
import CoreFoundation.CFFileSecurity
import CoreFoundation.CFLocale
import CoreFoundation.CFMachPort
import CoreFoundation.CFMessagePort
import CoreFoundation.CFNotificationCenter
import CoreFoundation.CFNumber
import CoreFoundation.CFNumberFormatter
import CoreFoundation.CFPlugIn
import CoreFoundation.CFPreferences
import CoreFoundation.CFPropertyList
import CoreFoundation.CFRunLoop
import CoreFoundation.CFSet
import CoreFoundation.CFSocket
import CoreFoundation.CFStream
import CoreFoundation.CFString
import CoreFoundation.CFStringEncodingExt
import CoreFoundation.CFStringTokenizer
import CoreFoundation.CFTimeZone
import CoreFoundation.CFTree
import CoreFoundation.CFURL
import CoreFoundation.CFURLAccess
import CoreFoundation.CFURLEnumerator
import CoreFoundation.CFUUID
import CoreFoundation.CFUtilities

/*	CoreFoundation.h
	Copyright (c) 1998-2014, Apple Inc. All rights reserved.
*/

var __COREFOUNDATION__: CInt { get }
/*-
 * Copyright (c) 1992, 1993
 *	The Regents of the University of California.  All rights reserved.
 * (c) UNIX System Laboratories, Inc.
 * All or some portions of this file are derived from material licensed
 * to the University of California by American Telephone and Telegraph
 * Co. or Unix System Laboratories, Inc. and are reproduced herein with
 * the permission of UNIX System Laboratories, Inc.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *	@(#)assert.h	8.2 (Berkeley) 1/21/94
 * $FreeBSD: src/include/assert.h,v 1.4 2002/03/23 17:24:53 imp Exp $
 */

/* __cplusplus */

/*
 * Unlike other ANSI header files, <assert.h> may usefully be included
 * multiple times, with and without NDEBUG defined.
 */

/* !__cplusplus */

/* __GNUC__ */

@noreturn func __assert_rtn(_: CString, _: CString, _: CInt, _: CString)
@noreturn func __assert_rtn(_: CString, _: CString, _: CInt, _: CString)
