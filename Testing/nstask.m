#include <Foundation/NSAutoreleasePool.h>
#include <Foundation/NSProcessInfo.h>
#include <Foundation/NSTask.h>

int
main()
{
  id pool;
  NSDictionary	*env;
  NSTask	*task;

  pool = [[NSAutoreleasePool alloc] init];

  task = [NSTask launchedTaskWithLaunchPath: @"/bin/ls"
				  arguments: nil];
  [task waitUntilExit];
  printf("Exit status - %d\n", [task terminationStatus]);

  [pool release];
  pool = [[NSAutoreleasePool alloc] init];

  task = [NSTask new];
  env = [[[[NSProcessInfo processInfo] environment] mutableCopy] autorelease];
  [task setEnvironment: env];
  [task setLaunchPath: @"/bin/sh"];
  [task setArguments: [NSArray arrayWithObjects: @"-c", @"echo $PATH", nil]];
  [task launch];
  [task waitUntilExit];
  [task release];
  [pool release];

  exit(0);
}

