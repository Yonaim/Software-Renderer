#include "platform.h"

int main(void) {
    platform_initialize();
    while (!window_should_close()) {
        // renderer_draw_frame();
        input_poll_events();
    }
    return (0);
}
