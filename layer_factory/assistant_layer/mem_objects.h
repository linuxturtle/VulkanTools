/*
 * Copyright (c) 2015-2017 Valve Corporation
 * Copyright (c) 2015-2017 LunarG, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Author: Mark Lobodzinski <mark@lunarg.com>
 */

#pragma once

#include <string>
#include <sstream>
#include <algorithm>

static const uint32_t kMemoryObjectWarningLimit = 350;

class TooManyMemObjects : public layer_factory {
public:
    // Constructor for interceptor
    TooManyMemObjects() : layer_factory(this) {
        _number_mem_objects = 0;
    };

    // Intercept the memory allocation calls and increment the counter
    VkResult PreCallAllocateMemory(VkDevice device, const VkMemoryAllocateInfo *pAllocateInfo,
                                   const VkAllocationCallbacks *pAllocator, VkDeviceMemory *pMemory) {
        _number_mem_objects++;

        if (_number_mem_objects > kMemoryObjectWarningLimit) {
            std::stringstream message;
            message << "Performance Warning:  This app has > " << kMemoryObjectWarningLimit << " memory objects.";
            PerformanceWarning(message.str());
        }
        return VK_SUCCESS;
    };

    // Intercept the free memory calls and decrement the allocation count
    void PreCallFreeMemory(VkDevice device, VkDeviceMemory memory, const VkAllocationCallbacks *pAllocator) {
        if (memory != VK_NULL_HANDLE) {
            _number_mem_objects--;
        }
    }

private:
    // Counter for the number of currently active memory allocations
    uint32_t _number_mem_objects;
};

TooManyMemObjects mem_object_count;
