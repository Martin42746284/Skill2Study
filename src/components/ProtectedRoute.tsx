import { ReactNode } from "react";
import { Navigate } from "react-router-dom";
import { isAuthenticated, getUserRole } from "@/lib/api";
import { useSettings } from "@/contexts/SettingsContext";
import Maintenance from "@/pages/Maintenance";

interface ProtectedRouteProps {
  children: ReactNode;
  requiredRole?: string | null;
}

/**
 * ProtectedRoute component to restrict access to authenticated users with specific roles
 * - If requiredRole is provided, it checks for that specific role
 * - If requiredRole is null, it only checks authentication
 * - Redirects to login if not authenticated, or to appropriate page if not authorized
 * - Shows maintenance page if maintenance mode is enabled (except for admins)
 */
const ProtectedRoute = ({ children, requiredRole = "admin" }: ProtectedRouteProps) => {
  const { settings } = useSettings();

  // Check if user is authenticated
  if (!isAuthenticated()) {
    return <Navigate to="/login" replace />;
  }

  const userRole = getUserRole();

  // Check if user has required role (only if requiredRole is specified)
  if (requiredRole !== null) {
    if (userRole !== requiredRole) {
      return <Navigate to="/dashboard" replace />;
    }
  }

  // Check maintenance mode (allow admins to bypass)
  if (settings.maintenance_mode && userRole !== "admin") {
    return <Maintenance />;
  }

  return <>{children}</>;
};

export default ProtectedRoute;
