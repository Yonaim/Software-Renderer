#ifndef PLATFORM_H
#define PLATFORM_H

#ifdef __cplusplus
extern "C"
{
#endif

	void platform_initialize(void);
	void input_poll_events(void);
	int  window_should_close(void);

#ifdef __cplusplus
}
#endif

#endif
