cmake_minimum_required(VERSION 3.21)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(AltSpamAssist VERSION 1.0.0)

# ── Geode SDK ─────────────────────────────────────────────────────────────────
# Geode CLI sets this automatically when you run `geode build`
# Manual path if building without CLI:
#   set(GEODE_SDK "C:/path/to/geode/sdk")
if(NOT DEFINED ENV{GEODE_SDK})
    if(NOT DEFINED GEODE_SDK)
        message(FATAL_ERROR
            "GEODE_SDK not set.\n"
            "Install Geode CLI: https://geode-sdk.org/install\n"
            "Then run: geode build\n"
            "Or set GEODE_SDK manually in CMakeLists.txt")
    endif()
else()
    set(GEODE_SDK "$ENV{GEODE_SDK}")
endif()

add_subdirectory(${GEODE_SDK} ${CMAKE_CURRENT_BINARY_DIR}/geode)

# ── Mod sources ───────────────────────────────────────────────────────────────
add_library(${PROJECT_NAME} SHARED
    src/main.cpp
    # headers are include-only, no separate compilation needed:
    # src/AltSpamEngine.hpp
    # src/RhythmIndicator.hpp
    # src/SettingsPopup.hpp
)

target_include_directories(${PROJECT_NAME} PRIVATE src/)

# ── Link Geode ────────────────────────────────────────────────────────────────
target_link_libraries(${PROJECT_NAME} geode-sdk)

# ── Geode packaging ───────────────────────────────────────────────────────────
setup_geode_mod(${PROJECT_NAME})
