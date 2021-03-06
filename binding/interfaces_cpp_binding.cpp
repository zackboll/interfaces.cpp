// BSD 2-Clause License
//
// Copyright (c) 2017, Zack Boll
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#include <interfaces_cpp_binding.hpp>
#include <string>

namespace interfaces {
namespace cpp {
namespace binding {

extern "C" {

  void *Interfaces_CPP_Empty_String_Constructor(void) {
    std::string *c_string = new std::string;
    return (void *)c_string;
  }

  void *Interfaces_CPP_Copy_String(void *input) {
    std::string *new_string = new std::string;
    std::string *old_string = (std::string *) input;
    (*new_string) = (*old_string);
    return (void *)new_string;
  }

  void Interfaces_CPP_Delete_String(void *input) {
    std::string *input_string = (std::string *)input;
    delete input_string;
  }

  const char *Interfaces_CPP_To_C_String(void *input) {
    std::string *input_str = (std::string *)input;
    return input_str->c_str();
  }

  void Interfaces_CPP_To_CPP_String (const char *src, void *dst) {
    std::string *dst_string = (std::string *)dst;
    (*dst_string) = std::string(src);
  }

} // end extern "C"

} // binding
} // cpp
} // interfaces
