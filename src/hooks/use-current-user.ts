import { useState, useEffect } from 'react';
import type { User } from '@/types';

export function useCurrentUser() {
  const [user, setUser] = useState<User | null>(null);

  useEffect(() => {
    const updateUser = () => {
      const userData = localStorage.getItem('orientai_user');
      setUser(userData ? JSON.parse(userData) : null);
    };

    // Get initial user
    updateUser();

    // Listen for storage changes from other tabs
    window.addEventListener('storage', updateUser);

    // Listen for custom events when user is updated in same tab
    window.addEventListener('userUpdated', updateUser);

    return () => {
      window.removeEventListener('storage', updateUser);
      window.removeEventListener('userUpdated', updateUser);
    };
  }, []);

  return user;
}
