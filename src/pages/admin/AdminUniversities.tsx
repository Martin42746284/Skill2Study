import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import type { University } from "@/types";
import {
  Building2,
  Search,
  Plus,
  MoreHorizontal,
  Eye,
  Pencil,
  Trash2,
  MapPin,
  GraduationCap,
  ChevronDown,
  ChevronRight,
  BookOpen,
  Globe,
  Phone,
} from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { useState, useRef, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { universities as universitiesApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { X, Image as ImageIcon } from "lucide-react";
import { downloadCSV } from "@/lib/export";

// Helper function to ensure URL has protocol
const ensureURLProtocol = (url: string): string => {
  if (!url.trim()) return '';
  if (url.match(/^https?:\/\//i)) return url;
  return `https://${url}`;
};

// Helper function to validate URL
const isValidURL = (url: string): boolean => {
  if (!url.trim()) return true; // Empty is valid (optional field)
  try {
    const urlObj = new URL(url);
    // Check if it's a valid domain (not localhost or local IPs for production URLs)
    const hostname = urlObj.hostname;
    return !hostname.includes('localhost') && !hostname.startsWith('127.') && !hostname.startsWith('192.') && !hostname.startsWith('10.');
  } catch {
    return false;
  }
};

const AdminUniversities = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [search, setSearch] = useState("");
  const [cityFilter, setCityFilter] = useState("all");
  const [unis, setUnis] = useState<University[]>([]);
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editingUni, setEditingUni] = useState<University | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [deletingId, setDeletingId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    const fetchUniversities = async () => {
      try {
        setLoading(true);
        const response = await universitiesApi.getAll() as any;
        let unis: University[] = [];

        if (Array.isArray(response)) {
          unis = response;
        } else if (response?.universites && Array.isArray(response.universites)) {
          unis = response.universites;
        } else if (response?.data && Array.isArray(response.data)) {
          unis = response.data;
        }

        setUnis(unis);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: error instanceof Error ? error.message : t("admin.pages.universities.loadingError"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };

    fetchUniversities();
  }, [t, toast]);

  const cities = Array.from(new Set(unis.map((u) => u.ville || u.city)));
  const types = Array.from(new Set(unis.map((u) => u.type)));

  const handleExportCSV = () => {
    const data = unis.map(u => ({
      ID: u.id,
      Nom: u.nom || u.name,
      Type: u.type === 'publique' ? 'Public' : 'Privé',
      Ville: u.ville || u.city,
      Email: u.email_contact || u.email || '',
      Téléphone: u.telephone || u.phone || '',
      'Site Web': u.site_web || u.website || '',
    }));
    downloadCSV(data, `universites-${new Date().toLocaleDateString('fr-FR')}.csv`);
    toast({ title: t("common.success"), description: `${unis.length} ${t("admin.pages.universities.noResults").toLowerCase()}` });
  };

  // Form state
  const [formName, setFormName] = useState("");
  const [formCity, setFormCity] = useState("");
  const [formType, setFormType] = useState("Public");
  const [formWebsite, setFormWebsite] = useState("");
  const [formEmail, setFormEmail] = useState("");
  const [formPhone, setFormPhone] = useState("");
  const [formCostEstimate, setFormCostEstimate] = useState("");
  const [formDuration, setFormDuration] = useState("");
  const [formDescription, setFormDescription] = useState("");
  const [formPhoto, setFormPhoto] = useState<string>("");

  const filtered = unis.filter((u) => {
    const uniName = u.nom || u.name || '';
    const uniCity = u.ville || u.city || '';
    const matchSearch = uniName.toLowerCase().includes(search.toLowerCase()) || uniCity.toLowerCase().includes(search.toLowerCase());
    const matchCity = cityFilter === "all" || uniCity === cityFilter;
    return matchSearch && matchCity;
  });

  const openAddDialog = () => {
    setEditingUni(null);
    setFormName(""); setFormCity(""); setFormType("publique");
    setFormWebsite(""); setFormEmail(""); setFormPhone(""); setFormCostEstimate(""); setFormDuration(""); setFormDescription("");
    setFormPhoto("");
    setDialogOpen(true);
  };

  const openEditDialog = (uni: University) => {
    setEditingUni(uni);
    setFormName(uni.nom || uni.name || "");
    setFormCity(uni.ville || uni.city || "");
    setFormType(uni.type || "publique");
    setFormWebsite(uni.site_web || uni.website || "");
    setFormEmail(uni.email_contact || uni.email || "");
    setFormPhone(uni.telephone || uni.phone || "");
    setFormCostEstimate(uni.cout_estimatif || uni.costEstimate || "");
    setFormDuration(uni.duree_etudes || uni.duration || "");
    setFormDescription(uni.description || "");
    setFormPhoto(uni.logo_url || uni.photo || "");
    setDialogOpen(true);
  };

  const handlePhotoChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Check file size (max 5MB)
      if (file.size > 5 * 1024 * 1024) {
        toast({ title: t("common.error"), description: t("admin.pages.universities.photoTooLarge"), variant: "destructive" });
        return;
      }

      const reader = new FileReader();
      reader.onload = (event) => {
        const result = event.target?.result as string;
        // Compress image
        const img = new Image();
        img.onload = () => {
          const canvas = document.createElement('canvas');
          let width = img.width;
          let height = img.height;

          // Resize if too large (max 1200px width/height)
          const maxSize = 1200;
          if (width > height) {
            if (width > maxSize) {
              height = Math.round((height * maxSize) / width);
              width = maxSize;
            }
          } else {
            if (height > maxSize) {
              width = Math.round((width * maxSize) / height);
              height = maxSize;
            }
          }

          canvas.width = width;
          canvas.height = height;
          const ctx = canvas.getContext('2d');
          ctx?.drawImage(img, 0, 0, width, height);

          // Compress to JPEG quality 0.7-0.8
          const compressedDataUrl = canvas.toDataURL('image/jpeg', 0.75);
          setFormPhoto(compressedDataUrl);
        };
        img.src = result;
      };
      reader.readAsDataURL(file);
    }
  };

  const removePhoto = () => {
    setFormPhoto("");
    if (fileInputRef.current) {
      fileInputRef.current.value = "";
    }
  };

  const handleSave = async () => {
    try {
      // Validation
      if (!formName.trim() || !formCity.trim() || !formType) {
        toast({ title: t("common.error"), description: t("admin.pages.universities.formRequiredFields"), variant: "destructive" });
        return;
      }

      // Format and validate website URL if provided
      let trimmedWebsite = formWebsite?.trim();
      if (trimmedWebsite) {
        trimmedWebsite = ensureURLProtocol(trimmedWebsite);
        if (!isValidURL(trimmedWebsite)) {
          toast({
          title: t("common.error"),
          description: t("admin.pages.universities.invalidURL"),
          variant: "destructive"
        });
          return;
        }
      }

      // Validate email if provided
      const trimmedEmail = formEmail?.trim();
      if (trimmedEmail && !trimmedEmail.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        toast({
          title: t("common.error"),
          description: t("admin.pages.universities.invalidEmail"),
          variant: "destructive"
        });
        return;
      }

      const commonData: any = {
        nom: formName.trim(),
        type: formType,
        ville: formCity.trim(),
        site_web: trimmedWebsite || null,
        email_contact: trimmedEmail || null,
        telephone: formPhone?.trim() || null,
        cout_estimatif: formCostEstimate?.trim() || null,
        duree_etudes: formDuration?.trim() || null,
        description: formDescription?.trim() || null,
        ...(formPhoto && { logo_url: formPhoto }),
      };

      if (editingUni) {
        // Update
        const response = await universitiesApi.update(editingUni.id, commonData) as any;
        const updatedUni = response?.universite || {
          ...editingUni,
          nom: formName,
          type: formType,
          ville: formCity,
          site_web: trimmedWebsite,
          email_contact: formEmail,
          telephone: formPhone,
        };
        setUnis(unis.map((u) => (u.id === editingUni.id ? updatedUni : u)));
        toast({ title: t("admin.pages.universities.editUniversity"), description: `${formName} ${t("admin.pages.universities.editedSuccessfully")}` });
      } else {
        // Create
        const response = await universitiesApi.create(commonData) as any;
        const newUni = response?.universite || {
          id: Date.now(),
          nom: formName,
          type: formType,
          ville: formCity,
          site_web: trimmedWebsite,
          email_contact: formEmail,
          telephone: formPhone,
        };
        setUnis([...unis, newUni]);
        toast({ title: t("admin.pages.universities.addNew"), description: `${formName} ${t("admin.pages.universities.addedSuccessfully")}` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : t("admin.pages.universities.savingError"),
        variant: "destructive"
      });
      console.error('Error saving university:', error);
    }
  };

  const handleDelete = async () => {
    if (deletingId === null) return;
    try {
      await universitiesApi.delete(deletingId);
      const deletedUni = unis.find((u) => u.id === deletingId);
      setUnis(unis.filter((u) => u.id !== deletingId));
      toast({
        title: t("admin.pages.universities.deleteUniversity"),
        description: deletedUni ? `${deletedUni.nom || deletedUni.name} ${t("admin.pages.universities.deletedSuccessfully")}` : t("admin.pages.universities.deletedSuccessfully"),
        variant: "destructive"
      });
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : t("admin.pages.universities.deletingError"),
        variant: "destructive"
      });
      console.error('Error deleting university:', error);
    } finally {
      setDeleteDialogOpen(false);
      setDeletingId(null);
    }
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center gap-4">
          {/* Left - Search inputs */}
          <div className="flex flex-col sm:flex-row gap-3 flex-1 sm:items-center">
            <div className="relative flex-1 max-w-md">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("admin.pages.universities.searchPlaceholder")} value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9 h-10" />
            </div>
            <Select value={cityFilter} onValueChange={setCityFilter}>
              <SelectTrigger className="w-full sm:w-[160px] h-10">
                <SelectValue placeholder={t("admin.pages.universities.filterByCity")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.pages.universities.all")}</SelectItem>
                {cities.map((c) => <SelectItem key={c} value={c}>{c}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>

          {/* Right - Counter & Buttons */}
          <div className="flex items-center gap-3 sm:justify-end flex-wrap">
            <div className="hidden sm:flex items-center px-3 py-1 rounded-lg bg-accent/30 border border-accent/50">
              <span className="text-xs font-medium text-muted-foreground">
                {unis.length} {t("admin.pages.universities.noResults").toLowerCase()}
              </span>
            </div>
            <div className="flex gap-2">
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button size="sm" variant="outline">
                    <Plus className="h-4 w-4 mr-1" /> {t("common.export")}
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={handleExportCSV}>
                    {t("admin.pages.universities.exportCSV")}
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
              <Button size="sm" onClick={openAddDialog}>
                <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.universities.addNew")}
              </Button>
            </div>
          </div>
        </div>

        <div className="space-y-4">
          {filtered.map((uni) => {
            const isExpanded = expandedId === String(uni.id);
            const uniName = uni.nom || uni.name || '';
            const uniCity = uni.ville || uni.city || '';
            const uniLocation = uni.adresse || uni.location || uniCity;
            return (
              <div key={uni.id} className="rounded-xl border bg-card shadow-sm overflow-hidden">
                {/* Header */}
                <div
                  className="p-5 cursor-pointer hover:bg-muted/30 transition-colors"
                  onClick={() => setExpandedId(isExpanded ? null : String(uni.id))}
                >
                  <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                    <div className="flex items-start gap-4 flex-1">
                      <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10 overflow-hidden">
                        {uni.logo_url ? (
                          <img
                            src={uni.logo_url}
                            alt={uniName}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <Building2 className="h-5 w-5 text-primary" />
                        )}
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2 mb-1">
                          {isExpanded ? <ChevronDown className="h-4 w-4 text-muted-foreground" /> : <ChevronRight className="h-4 w-4 text-muted-foreground" />}
                          <h3 className="font-semibold">{uniName}</h3>
                          <Badge variant="secondary" className="text-[10px]">{uni.type === 'publique' ? t("admin.pages.universities.public") : t("admin.pages.universities.private")}</Badge>
                        </div>
                        <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-muted-foreground mt-1">
                          <span className="flex items-center gap-1"><MapPin className="h-3 w-3" /> {uniCity}</span>
                          {uni.type && <span>{uni.type === 'publique' ? t("admin.pages.universities.public") : t("admin.pages.universities.private")}</span>}
                        </div>
                      </div>
                    </div>

                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={(e) => e.stopPropagation()}>
                          <MoreHorizontal className="h-4 w-4" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => setExpandedId(isExpanded ? null : String(uni.id))}>
                          <Eye className="h-4 w-4 mr-2" /> {t("admin.pages.universities.viewDetails")}
                        </DropdownMenuItem>
                        <DropdownMenuItem onClick={() => openEditDialog(uni)}>
                          <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.universities.editAction")}
                        </DropdownMenuItem>
                        <DropdownMenuItem className="text-destructive" onClick={() => { setDeletingId(uni.id); setDeleteDialogOpen(true); }}>
                          <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.universities.deleteAction")}
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </div>
                </div>

                {/* Expanded */}
                {isExpanded && (
                  <div className="border-t px-5 py-4 bg-muted/20 space-y-4">
                    {/* Contact */}
                    <div className="space-y-2">
                      <div className="flex flex-wrap gap-4 text-xs text-muted-foreground">
                        <span className="flex items-center gap-1"><MapPin className="h-3 w-3" /> {uniLocation}</span>
                        {uni.site_web && (
                          <span className="flex items-center gap-1"><Globe className="h-3 w-3" /> <a href={uni.site_web} target="_blank" rel="noopener noreferrer" className="hover:text-primary">{uni.site_web}</a></span>
                        )}
                        {uni.telephone && (
                          <span className="flex items-center gap-1"><Phone className="h-3 w-3" /> {uni.telephone}</span>
                        )}
                      </div>
                      {uni.email_contact && (
                        <div className="text-xs text-muted-foreground">
                          <span className="font-medium">Email:</span> <a href={`mailto:${uni.email_contact}`} className="hover:text-primary">{uni.email_contact}</a>
                        </div>
                      )}
                      {uni.description && (
                        <div className="text-xs text-muted-foreground pt-2 border-t">
                          <p>{uni.description}</p>
                        </div>
                      )}
                    </div>

                    {/* Info */}
                    {(uni.duree_etudes || uni.cout_estimatif) && (
                      <div className="grid gap-3 sm:grid-cols-2 text-xs">
                        {uni.duree_etudes && (
                          <div className="rounded-lg border bg-card p-3">
                            <p className="text-muted-foreground">{t("admin.pages.universities.duration")}</p>
                            <p className="font-medium">{uni.duree_etudes}</p>
                          </div>
                        )}
                        {uni.cout_estimatif && (
                          <div className="rounded-lg border bg-card p-3">
                            <p className="text-muted-foreground">{t("admin.pages.universities.cost")}</p>
                            <p className="font-medium">{uni.cout_estimatif}</p>
                          </div>
                        )}
                      </div>
                    )}

                    {/* Filières */}
                    {uni.filieres && uni.filieres.length > 0 && (
                      <div className="rounded-lg border bg-card p-3">
                        <div className="flex items-center gap-2 mb-3">
                          <GraduationCap className="h-4 w-4 text-primary" />
                          <p className="font-semibold">{uni.filieres.length} {uni.filieres.length > 1 ? t("admin.pages.universities.filieresPlural") : t("admin.pages.universities.filiereSingular")}</p>
                        </div>
                        <div className="space-y-2">
                          {uni.filieres.map((fil: any) => (
                            <div key={fil.id} className="rounded-lg border bg-background p-2 text-xs">
                              <div className="flex items-center justify-between mb-1">
                                <span className="font-medium">{fil.nom}</span>
                                <Badge variant="secondary" className="text-[8px]">{fil.niveau}</Badge>
                              </div>
                              {fil.domaine && <p className="text-muted-foreground mb-1">{t("admin.pages.universities.domain")}: {fil.domaine}</p>}
                              {fil.parcours && fil.parcours.length > 0 && (
                                <div className="pl-2 border-l-2 border-primary mt-1">
                                  <p className="text-muted-foreground text-[10px] mb-1">{t("admin.pages.universities.programs")}:</p>
                                  <div className="flex flex-wrap gap-1">
                                    {fil.parcours.map((par: any) => (
                                      <Badge key={par.id} variant="outline" className="text-[7px]">
                                        {par.nom}
                                      </Badge>
                                    ))}
                                  </div>
                                </div>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>

        {filtered.length === 0 && (
          <div className="p-12 text-center text-muted-foreground">
            <Building2 className="h-10 w-10 mx-auto mb-2 opacity-40" />
            <p>{t("admin.pages.universities.noResults")}</p>
          </div>
        )}

        {/* Add/Edit Dialog */}
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{editingUni ? t("admin.pages.universities.editUniversity") : t("admin.pages.universities.addUniversity")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2">
              {/* Photo Upload */}
              <div className="space-y-1.5">
                <Label>{t("admin.pages.universities.formPhoto")}</Label>
                <div className="relative">
                  <input
                    ref={fileInputRef}
                    type="file"
                    accept="image/*"
                    onChange={handlePhotoChange}
                    className="hidden"
                  />
                  {formPhoto ? (
                    <div className="relative rounded-lg overflow-hidden border-2 border-primary">
                      <img
                        src={formPhoto}
                        alt="Preview"
                        className="w-full h-40 object-cover"
                      />
                      <button
                        type="button"
                        onClick={removePhoto}
                        className="absolute top-2 right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600"
                      >
                        <X className="h-4 w-4" />
                      </button>
                    </div>
                  ) : (
                    <button
                      type="button"
                      onClick={() => fileInputRef.current?.click()}
                      className="w-full border-2 border-dashed rounded-lg p-8 text-center hover:bg-muted/50 transition-colors"
                    >
                      <ImageIcon className="h-8 w-8 mx-auto mb-2 text-muted-foreground" />
                      <p className="text-sm text-muted-foreground">{t("admin.pages.universities.formPhotoUpload")}</p>
                      <p className="text-xs text-muted-foreground mt-1">{t("admin.pages.universities.formPhotoDragDrop")}</p>
                    </button>
                  )}
                </div>
              </div>

              <div className="space-y-1.5">
                <Label>{t("admin.pages.universities.formName")}</Label>
                <Input value={formName} onChange={(e) => setFormName(e.target.value)} placeholder={t("admin.pages.universities.formNamePlaceholder")} />
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.formCity")}</Label>
                  <Input value={formCity} onChange={(e) => setFormCity(e.target.value)} placeholder={t("admin.pages.universities.formCityPlaceholder")} />
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.formType")}</Label>
                  <Select value={formType} onValueChange={setFormType}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="publique">{t("admin.pages.universities.public")}</SelectItem>
                      <SelectItem value="privee">{t("admin.pages.universities.private")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.formWebsite")}</Label>
                  <Input value={formWebsite} onChange={(e) => setFormWebsite(e.target.value)} placeholder={t("admin.pages.universities.formWebsitePlaceholder")} />
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.formEmail")}</Label>
                  <Input type="email" value={formEmail} onChange={(e) => setFormEmail(e.target.value)} placeholder={t("admin.pages.universities.formEmailPlaceholder")} />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.universities.formPhone")}</Label>
                <Input value={formPhone} onChange={(e) => setFormPhone(e.target.value)} placeholder={t("admin.pages.universities.formPhonePlaceholder")} />
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.formCost")}</Label>
                  <Input value={formCostEstimate} onChange={(e) => setFormCostEstimate(e.target.value)} placeholder={t("admin.pages.universities.formCostPlaceholder")} />
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.formDuration")}</Label>
                  <Input value={formDuration} onChange={(e) => setFormDuration(e.target.value)} placeholder={t("admin.pages.universities.formDurationPlaceholder")} />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.universities.formDescription")}</Label>
                <textarea
                  value={formDescription}
                  onChange={(e) => setFormDescription(e.target.value)}
                  placeholder={t("admin.pages.universities.formDescriptionPlaceholder")}
                  rows={3}
                  className="w-full px-3 py-2 rounded-md border border-input bg-background text-sm resize-none focus:outline-none focus:ring-2 focus:ring-ring"
                />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setDialogOpen(false)}>{t("admin.pages.universities.cancel")}</Button>
              <Button onClick={handleSave} disabled={!formName.trim() || !formCity.trim() || !formType}>
                {editingUni ? t("admin.pages.universities.save") : t("admin.pages.universities.addNew")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation Dialog */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.universities.deleteConfirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.pages.universities.confirmDelete")}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="flex gap-3 justify-end">
              <AlertDialogCancel>{t("admin.pages.universities.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.universities.delete")}
              </AlertDialogAction>
            </div>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminUniversities;
