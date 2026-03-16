// queue.hpp
// Thread-safe queue implementation

#ifndef QUEUE_HPP
#define QUEUE_HPP

#include <cstddef>
#include <mutex>

template<typename T, size_t MAX_SIZE = 100>
class Queue {
private:
    T buffer[MAX_SIZE];
    size_t head;
    size_t tail;
    size_t count;
    mutable std::mutex mtx;
    
public:
    Queue() : head(0), tail(0), count(0) {}
    
    bool push(const T& item) {
        std::lock_guard<std::mutex> lock(mtx);
        if (count >= MAX_SIZE) {
            return false;
        }
        buffer[tail] = item;
        tail = (tail + 1) % MAX_SIZE;
        count++;
        return true;
    }
    
    bool pop(T& item) {
        std::lock_guard<std::mutex> lock(mtx);
        if (count == 0) {
            return false;
        }
        item = buffer[head];
        head = (head + 1) % MAX_SIZE;
        count--;
        return true;
    }
    
    size_t size() const {
        std::lock_guard<std::mutex> lock(mtx);
        return count;
    }
    
    bool empty() const {
        std::lock_guard<std::mutex> lock(mtx);
        return count == 0;
    }
    
    bool full() const {
        std::lock_guard<std::mutex> lock(mtx);
        return count >= MAX_SIZE;
    }
};

#endif // QUEUE_HPP
