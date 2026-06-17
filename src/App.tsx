import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { SettingsProvider } from "@/contexts/SettingsContext";
import ProtectedRoute from "@/components/ProtectedRoute";
import Index from "./pages/Index";
import Login from "./pages/Login";
import Logout from "./pages/Logout";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import OrientationTest from "./pages/OrientationTest";
import TestsList from "./pages/TestsList";
import Recommendations from "./pages/Recommendations";
import Compare from "./pages/Compare";
import UniversityDetails from "./pages/UniversityDetails";
import AdminOverview from "./pages/admin/AdminOverview";
import AdminUsers from "./pages/admin/AdminUsers";
import AdminUniversities from "./pages/admin/AdminUniversities";
import AdminFilieres from "./pages/admin/AdminFilieres";
import AdminParcours from "./pages/admin/AdminParcours";
import AdminTests from "./pages/admin/AdminTests";
import AdminTestimonials from "./pages/admin/AdminTestimonials";
import AdminSettings from "./pages/admin/AdminSettings";
import AdminRules from "./pages/admin/AdminRules";
import AdminStatistics from "./pages/admin/AdminStatistics";
import Profile from "./pages/Profile";
import MapExplorer from "./pages/MapExplorer";
import About from "./pages/About";
import History from "./pages/History";
import Settings from "./pages/Settings";
import Guide from "./pages/Guide";
import FAQ from "./pages/FAQ";
import Blog from "./pages/Blog";
import Notifications from "./pages/Notifications";
import Search from "./pages/Search";
import TestResults from "./pages/TestResults";
import Favorites from "./pages/Favorites";
import Maintenance from "./pages/Maintenance";
import VerifyEmail from "./pages/VerifyEmail";
import CheckEmail from "./pages/CheckEmail";
import ForgotPassword from "./pages/ForgotPassword";
import ResetPassword from "./pages/ResetPassword";
import GoogleAuthCallback from "./pages/GoogleAuthCallback";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <SettingsProvider>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <Routes>
          <Route path="/" element={<Index />} />
          <Route path="/login" element={<Login />} />
          <Route path="/logout" element={<Logout />} />
          <Route path="/register" element={<Register />} />
          <Route path="/auth/google/callback" element={<GoogleAuthCallback />} />
          <Route path="/check-email" element={<CheckEmail />} />
          <Route path="/verify-email" element={<VerifyEmail />} />
          <Route path="/forgot-password" element={<ForgotPassword />} />
          <Route path="/reset-password" element={<ResetPassword />} />
          <Route path="/dashboard" element={<ProtectedRoute requiredRole={null}><Dashboard /></ProtectedRoute>} />
          <Route path="/tests" element={<ProtectedRoute requiredRole={null}><TestsList /></ProtectedRoute>} />
          <Route path="/test/:id" element={<ProtectedRoute requiredRole={null}><OrientationTest /></ProtectedRoute>} />
          <Route path="/recommendations" element={<ProtectedRoute requiredRole={null}><Recommendations /></ProtectedRoute>} />
          <Route path="/compare" element={<ProtectedRoute requiredRole={null}><Compare /></ProtectedRoute>} />
          <Route path="/university/:id" element={<UniversityDetails />} />
          
          <Route path="/admin" element={<ProtectedRoute><AdminOverview /></ProtectedRoute>} />
          <Route path="/admin/users" element={<ProtectedRoute><AdminUsers /></ProtectedRoute>} />
          <Route path="/admin/universities" element={<ProtectedRoute><AdminUniversities /></ProtectedRoute>} />
          <Route path="/admin/filieres" element={<ProtectedRoute><AdminFilieres /></ProtectedRoute>} />
          <Route path="/admin/parcours" element={<ProtectedRoute><AdminParcours /></ProtectedRoute>} />
          <Route path="/admin/tests" element={<ProtectedRoute><AdminTests /></ProtectedRoute>} />
          <Route path="/admin/testimonials" element={<ProtectedRoute><AdminTestimonials /></ProtectedRoute>} />
          <Route path="/admin/settings" element={<ProtectedRoute><AdminSettings /></ProtectedRoute>} />
          <Route path="/admin/rules" element={<ProtectedRoute><AdminRules /></ProtectedRoute>} />
          <Route path="/admin/statistics" element={<ProtectedRoute><AdminStatistics /></ProtectedRoute>} />
          <Route path="/dashboard/profile" element={<ProtectedRoute requiredRole={null}><Profile /></ProtectedRoute>} />
          <Route path="/dashboard/map" element={<ProtectedRoute requiredRole={null}><MapExplorer /></ProtectedRoute>} />
          <Route path="/dashboard/history" element={<ProtectedRoute requiredRole={null}><History /></ProtectedRoute>} />
          <Route path="/dashboard/settings" element={<ProtectedRoute requiredRole={null}><Settings /></ProtectedRoute>} />

          <Route path="/dashboard/notifications" element={<ProtectedRoute requiredRole={null}><Notifications /></ProtectedRoute>} />
          <Route path="/dashboard/favorites" element={<ProtectedRoute requiredRole={null}><Favorites /></ProtectedRoute>} />
          <Route path="/dashboard/search" element={<ProtectedRoute requiredRole={null}><Search /></ProtectedRoute>} />
          <Route path="/test/:id/results" element={<ProtectedRoute requiredRole={null}><TestResults /></ProtectedRoute>} />
          <Route path="/about" element={<About />} />
          <Route path="/guide" element={<Guide />} />
          <Route path="/faq" element={<FAQ />} />
          <Route path="/blog" element={<Blog />} />
          <Route path="/maintenance" element={<Maintenance />} />
          <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </TooltipProvider>
    </SettingsProvider>
  </QueryClientProvider>
);

export default App;
