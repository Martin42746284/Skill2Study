import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { auth } from '@/lib/api';

const Logout = () => {
  const navigate = useNavigate();

  useEffect(() => {
    // Logout and remove token
    auth.logout();
    
    // Redirect to home page
    navigate('/', { replace: true });
  }, [navigate]);

  return null;
};

export default Logout;
