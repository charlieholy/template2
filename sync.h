#include <windows.h>
#include <mutex>
#include <iostream>
using namespace std;
class LockC
{
public:
	//the default constructor
	LockC(std::mutex &mutex) : m_mutex(mutex), m_locked(true)
	{
		m_mutex.lock();
	}

	//the destructor
	~LockC()
	{
		m_mutex.unlock();
	}

	//report the state of locking when used as a boolean
	operator bool() const
	{
		return m_locked;
	}

	//unlock
	void setUnlock()
	{
		m_locked = false;
	}

private:
	std::mutex& m_mutex;
	bool m_locked;
};

#define synchronized(M)  for(LockC M##_lock = M; M##_lock; M##_lock.setUnlock())

//thread count
int thread_countt = 0;

//mutex
std::mutex mutex11;

//example thread
void thread_procc()
{
	for (int i = 0; i < 10; ++i)
	{
		synchronized(mutex11)
		{
			for (char c = 'A'; c <= 'Z'; ++c)
			{
				cout << c;
			}
			cout << endl;
		}
	}
	thread_countt--;
}

//main
#if 0
int main()
{
	thread_countt = 2;
	std::thread t1(thread_procc);
	std::thread t2(thread_procc);
	while (thread_countt) Sleep(0);
	getchar();
	return 0;
}
#endif
