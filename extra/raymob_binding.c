#include <raymob.h>

struct raymob_bind_entry {
  const char *name;
  const char *proto;
  void *ptr;
};

struct raymob_bind_entry bind_entries[] = {
  {"GetAndroidApp", "void*(*)(void)", GetAndroidApp},
  {"AttachCurrentThread", "JNIEnv* (*)(void)", AttachCurrentThread},
  {"DetachCurrentThread", "void (*)(void)", DetachCurrentThread},
  {"GetNativeLoaderInstance", "jobject (*)(void)", GetNativeLoaderInstance},
  {"GetFeaturesInstance", "jobject (*)(void)", GetFeaturesInstance},
  {"GetCacheDir", "char* (*)(void)", GetCacheDir},
  {"Vibrate", "void (*)(float)", Vibrate},
  {"StartAccelerometerListening", "void (*)(void)", StartAccelerometerListening},
  {"StopAccelerometerListening", "void (*)(void)", StopAccelerometerListening},
  {"GetAccelerometerAxis", "Vector3 (*)(void)", GetAccelerometerAxis},
  {"GetAccelerometerX", "float (*)(void)", GetAccelerometerX},
  {"GetAccelerometerY", "float (*)(void)", GetAccelerometerY},
  {"GetAccelerometerZ", "float (*)(void)", GetAccelerometerZ},
  {"ShowSoftKeyboard", "void (*)(void)", ShowSoftKeyboard},
  {"HideSoftKeyboard", "void (*)(void)", HideSoftKeyboard},
  {"IsSoftKeyboardActive", "bool (*)(void)", IsSoftKeyboardActive},
  {"GetLastSoftKeyCode", "int (*)(void)", GetLastSoftKeyCode},
  {"GetLastSoftKeyLabel", "unsigned short (*)(void)", GetLastSoftKeyLabel},
  {"GetLastSoftKeyUnicode", "int (*)(void)", GetLastSoftKeyUnicode},
  {"GetLastSoftKeyChar", "char (*)(void)", GetLastSoftKeyChar},
  {"ClearLastSoftKey", "void (*)(void)", ClearLastSoftKey},
  {"SoftKeyboardEditText", "void (*)(char*, unsigned int)", SoftKeyboardEditText},
  {"KeepScreenOn", "void (*)(bool)", KeepScreenOn},  
};
