-- BSD 2-Clause License
--
-- Copyright (c) 2017, Zack Boll
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- * Redistributions of source code must retain the above copyright notice,
--   this list of conditions and the following disclaimer.
--
-- * Redistributions in binary form must reproduce the above copyright notice,
--   this list of conditions and the following disclaimer in the documentation
--   and/or other materials provided with the distribution.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.

with Interfaces.C.Extensions; use Interfaces.C.Extensions;

package body Interfaces_CPP.Strings is

  function CPP_Empty_String_Constructor return void_ptr;
  pragma Import (C, CPP_Empty_String_Constructor,
                 "Interfaces_CPP_Empty_String_Constructor");

  procedure Initialize (Object : in out CPP_String) is

  begin

    --
    -- Allocate empty string
    --
    Object.cpp_str := CPP_Empty_String_Constructor;

  end Initialize;

  procedure Adjust     (Object : in out CPP_String) is

  begin

    null;

  end Adjust;

  procedure Finalize   (Object : in out CPP_String) is

  begin

    null;

  end Finalize;

end Interfaces_CPP.Strings;
