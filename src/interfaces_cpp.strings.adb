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
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C; use Interfaces.C;

package body Interfaces_CPP.Strings is

  --
  -- Thin bindings to C layer std::string
  --
  function CPP_Empty_String_Constructor return CPP_String_External;
  pragma Import (C, CPP_Empty_String_Constructor,
                 "Interfaces_CPP_Empty_String_Constructor");

  function CPP_Copy_String (Input: CPP_String_External)
                            return CPP_String_External;
  pragma Import (C, CPP_Copy_String, "Interfaces_CPP_Copy_String");

  procedure CPP_Delete_String (Input: CPP_String_External);
  pragma Import (C, CPP_Delete_String, "Interfaces_CPP_Delete_String");

  function CPP_To_C_String (Input: CPP_String_External)
                            return Interfaces.C.Strings.chars_ptr;
  pragma Import (C, CPP_To_C_String, "Interfaces_CPP_To_C_String");

  procedure C_To_CPP_String (Src: Interfaces.C.Strings.chars_ptr;
                             Dst: CPP_String_External);
  pragma Import (C, C_To_CPP_String, "Interfaces_CPP_To_CPP_String");

  -------------------------------------------------------------------------

  procedure Initialize (Object : in out CPP_String) is

  begin

    --
    -- Allocate empty string
    --
    Object.cpp_str := CPP_Empty_String_Constructor;

  end Initialize;

  procedure Adjust (Object : in out CPP_String) is

  begin

    Object.cpp_str := CPP_Copy_String (Object.cpp_str);

  end Adjust;

  procedure Finalize (Object : in out CPP_String) is

  begin

    CPP_Delete_String (Object.cpp_str);

  end Finalize;

  function To_Ada (Input: Interfaces.C.Strings.chars_ptr) return String is

  begin

    return Interfaces.C.Strings.Value (Input);

  end To_Ada;

  function To_Ada (Object: CPP_String) return String is

  begin

    return To_Ada (CPP_To_C_String (Object.cpp_str));

  end To_Ada;

  function To_Ada (External: CPP_String_External) return String is

  begin

    return To_Ada (CPP_To_C_String (External));

  end To_Ada;

  function To_CPP (Input: String) return CPP_String is

    c_string : aliased Interfaces.C.char_array := To_C (Input);
    --
    -- :TODO This should probably be done better but wanted to avoid another
    -- dynamic memory allocationi
    --
    c_string_ptr : chars_ptr := To_Chars_Ptr (c_string'Unrestricted_Access);

    Object : CPP_String;

  begin

    C_To_CPP_String (Src => c_string_ptr, Dst => Object.cpp_str);
    return Object;

  end To_CPP;

  function To_CPP_External (Input: CPP_String) return CPP_String_External is

  begin

    return Input.cpp_str;

  end To_CPP_External;

end Interfaces_CPP.Strings;
